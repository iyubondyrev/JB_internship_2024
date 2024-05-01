import subprocess
import os
import argparse

def split_file(filename, lines_per_file):
    smallfile = None
    with open(filename, 'r') as bigfile:
        for lineno, line in enumerate(bigfile):
            if lineno % lines_per_file == 0:
                if smallfile:
                    smallfile.close()
                small_filename = f'{filename}_{lineno // lines_per_file + 1}.txt'
                smallfile = open(small_filename, 'w')
            smallfile.write(line)
        if smallfile:
            smallfile.close()

def run_java_commands(args, chunks):
    with open('train_errors.txt', 'w') as error_file:
        for i in range(1, chunks + 1):
            input_file = f"{args.file_names}_{i}.txt"
            output_file_token_prefix = args.result_file_token_completion.split(".")[0]
            output_file_method_prefix = args.result_file_token_completion.split(".")[0]
            output_file_token = f"{output_file_token_prefix}_{i}.txt"
            output_file_method = f"{output_file_method_prefix}_{i}.json"
            cmd = f"java -jar Preprocess.jar --base_dir=\"{args.base_dir}\" " \
                f"--output_dir_token_completion=\"{args.output_dir_token_completion}\" " \
                f"--output_dir_method_generation=\"{args.output_dir_method_generation}\" " \
                f"--file_names='{input_file}' " \
                f"--result_file_token_completion='{output_file_token}' " \
                f"--result_file_method_generation='{output_file_method}' " \
                f"--literal_file_path='{args.literal_file_path}' " \
                f"--tokens_threshold_to_parse={args.tokens_threshold_to_parse}"
            subprocess.run(cmd, shell=True, stderr=error_file, check=True)
            print("--------------------------------------")
            print(f"Prerocessed {i} chunk out of {chunks} chunks")
            print("--------------------------------------")

def merge_files(output_dir, pattern, output_file):
    with open(output_file, 'w') as outfile:
        for filename in sorted(os.listdir(output_dir)):
            if filename.startswith(pattern):
                with open(os.path.join(output_dir, filename), 'r') as readfile:
                    outfile.write(readfile.read())

def clean_up(args, chunks):
    for i in range(1, chunks + 1):
        outpu_file_token_prefix = args.result_file_token_completion.split(".")[0]
        outpu_file_method_prefix = args.result_file_token_completion.split(".")[0]

        os.remove(f"{args.base_dir}/{args.file_names}_{i}.txt")
        os.remove(f"{args.output_dir_token_completion}/{outpu_file_token_prefix}_{i}.txt")
        os.remove(f"{args.output_dir_method_generation}/{outpu_file_method_prefix}_{i}.json")

def main():
    parser = argparse.ArgumentParser(description="Process some files for Java preprocessing.")
    parser.add_argument('--base_dir', type=str, default="kotlin_data",
                        help='Base directory where the train files are located')
    parser.add_argument('--output_dir_token_completion', type=str, default="token_completion",
                        help='Output directory for token completion files')
    parser.add_argument('--output_dir_method_generation', type=str, default="method_generation",
                        help='Output directory for method generation files')
    parser.add_argument('--file_names', type=str, default="train_file_names.txt",
                        help='Filename containing the train file names')
    parser.add_argument('--result_file_token_completion', type=str, default="train.txt",
                        help='Resulting file name for token completions')
    parser.add_argument('--result_file_method_generation', type=str, default="train.json",
                        help='Resulting file name for method generations')
    parser.add_argument('--literal_file_path', type=str, default="literals.json",
                        help='Path to the literals file used in processing')
    parser.add_argument('--max_lines', type=int, default=3000,
                        help='Maximum number of lines per chunk file')
    parser.add_argument('--tokens_threshold_to_parse', type=int, default=10000,
                        help='Max number of tokens to parse')

    args = parser.parse_args()



    split_file(f"{args.base_dir}/{args.file_names}", args.max_lines)
    chunks = (sum(1 for _ in open(f"{args.base_dir}/{args.file_names}")) + args.max_lines - 1) // args.max_lines

    run_java_commands(args, chunks)

    output_file_token_prefix = args.result_file_token_completion.split(".")[0]
    output_file_method_prefix = args.result_file_method_generation.split(".")[0]
    output_file_token_completion = f"{args.output_dir_token_completion}/{args.result_file_token_completion}"
    output_file_method_generation = f"{args.output_dir_method_generation}/{args.result_file_method_generation}"
    merge_files(output_dir=args.output_dir_token_completion, pattern=f"{output_file_token_prefix}_", output_file=output_file_token_completion)
    merge_files(output_dir=args.output_dir_method_generation, pattern=f"{output_file_method_prefix}_", output_file=output_file_method_generation)

    clean_up(args, chunks)

if __name__ == "__main__":
    main()
