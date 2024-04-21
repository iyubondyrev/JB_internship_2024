from antlr4 import *

# just to fix relative import
import sys, os
sys.path.append(os.path.join(os.path.dirname(__file__), '..'))

from kotlin_grammar.KotlinLexer import KotlinLexer

import os
from typing import List
import argparse
import re

popular_literals = []

def process_string(tokens_of_string: List[Token], special_chars={" ": "U+0020", ",": "U+002C"}) -> str:
    # TODO: if TRIPLE_QUOTE => always STR_LIT
    return "<STR_LIT>"

def process_all_tokens(all_tokens: List[Token], lexer: KotlinLexer) -> List[str]:
    # TODO: delete lexer from here
    result_strings: List[str] = []
    i: int = 0
    while i < len(all_tokens):

        # hidden channel, tokens like whitespaces, etc. => skip
        if all_tokens[i].channel == 1:
            i += 1
    
        # quote open => get all the tokens related to the string in quotes
        elif all_tokens[i].type in [lexer.QUOTE_OPEN, lexer.TRIPLE_QUOTE_OPEN]:
            tokens_of_string_lit: List[Token] = [all_tokens[i]]
            i += 1
            # it is ok because it is either QUOTE_OPEN or TRIPLE_QUOTE_OPEN
            # there can't be 2 types in one string
            while not (all_tokens[i].type in [lexer.QUOTE_CLOSE, lexer.TRIPLE_QUOTE_CLOSE]):
                #print(all_tokens[i])
                tokens_of_string_lit.append(all_tokens[i])
                i += 1
            tokens_of_string_lit.append(all_tokens[i])
            result_strings.append(process_string(tokens_of_string_lit))
            i += 1
        
        # literals
        # these [137..147] are the keys for literals, see KotlinLexer.py
        elif (137 <= all_tokens[i].type <= 147):
            if (all_tokens[i] in [lexer.BooleanLiteral, lexer.NullLiteral]):
                result_strings.append(all_tokens[i].text) # we want to keep bool, null as it is
                i += 1
                continue
            if all_tokens[i].text in popular_literals:
                result_strings.append(f"<NUM_LIT:{all_tokens[i].text}>")
            else:
                result_strings.append("<NUM_LIT>")
            i += 1
        
        # newline
        elif all_tokens[i].type == lexer.NL:
            if result_strings[-1] != "<EOL>":
                result_strings.append("<EOL>")
            i += 1

        # all other tokens
        else:
            result_strings.append(all_tokens[i].text)
            i += 1
    
    if result_strings[0] == "<EOL>":
        result_strings = result_strings[1:]
    if result_strings[-1] == "<EOL>":
        result_strings = result_strings[:-1]
    
    return result_strings


def tokenize_kotlin(args, file_name_with_paths: str, file_type: str) -> None:
    file_paths = open(os.path.join(args.base_dir, file_name_with_paths)).readlines()
    lexer = KotlinLexer()
    with open(os.path.join(args.output_dir, f"{file_type}.txt"), 'w') as result_file:
        for file_num, path in enumerate(file_paths):
            
            full_path: str = os.path.join(args.base_dir, path.strip())
            input_stream = FileStream(full_path)
            lexer.inputStream = input_stream
            all_tokens: List[Token] = lexer.getAllTokens()

            try:
                result_strings: List[str] = process_all_tokens(all_tokens, lexer)
            except Exception as e:
                # TODO Remove raise
                raise e
                print(e)
                result_strings = []
            
            result_strings = ["<s>"] + result_strings + ["</s>"]
            result_str = " ".join(result_strings)
            result_file.write(result_str + "\n")
            if file_num % 10000 == 0:
                print(f"{file_type}: {file_num} are done")

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--base_dir", required=True, type=str, 
                        help="The downloaded data path")
    parser.add_argument("--output_dir", default="token_completion", type=str, 
                        help="The output directory")

    args = parser.parse_args()

    if not os.path.exists(args.output_dir):
        os.makedirs(args.output_dir)


    tokenize_kotlin(args, file_name_with_paths="kotlin_train_files.txt", file_type="train")
    tokenize_kotlin(args, file_name_with_paths="kotlin_validation_files.txt", file_type="dev")
    tokenize_kotlin(args, file_name_with_paths="kotlin_test_files.txt", file_type="test")

if __name__ == "__main__":
    main()



    

