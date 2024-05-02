# Copyright (c) Microsoft Corporation. 
# Licensed under the MIT license.
import os
import logging
import argparse
from typing import Tuple

logger = logging.getLogger(__name__)
logging.basicConfig(level=logging.INFO)

def calculate_accuracy(answers_file_name: str, predictions_file_name: str, logger: logging.Logger) -> Tuple[int, int]:
    preds = open(predictions_file_name, "r").readlines()
    gts = open(answers_file_name, "r").readlines()

    assert len(preds) == len(gts), f"Samples of predictions and answers are not equal, {len(preds)}: {len(gts)}"

    total = 0
    correct = 0.0
    for pred, gt in zip(preds, gts):
        pred = pred.split()
        gt = gt.split()
        assert len(pred) == len(gt), f"Sequence length of prediction and answer are not equal, {len(pred)}: {len(gt)}"
        for x, y in zip(pred, gt):
            if y not in ["<s>", "</s>", "<EOL>", "<pad>"]:
                total += 1
                if x == y:
                    correct += 1
    
    acc = correct/total*100
    logger.info(f"Total {total} tokens, accuracy: {round(acc, 2)}")
    
    return total, acc

def main():
    parser = argparse.ArgumentParser(description='Evaluate leaderboard predictions for code completion (token level).')
    parser.add_argument('--answers', '-a', required=True, help="filename of the labels, in txt format.")
    parser.add_argument('--predictions', '-p', required=True, help="filename of the leaderboard predictions, in txt format.")
    args = parser.parse_args()

    total, acc = calculate_accuracy(answers_file_name=args.answers, predictions_file_name=args.predictions, logger=logger)

if __name__ == "__main__":
    main()
