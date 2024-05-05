
# Code Completion Project README

This repository is designed for the task of adapting and evaluating a transformer model for code completion tasks in Kotlin and Python, focusing on using large open-source projects written in Kotlin for dataset creation.

## Project Structure Overview

- **datasets/**: Contains the datasets for method generation and token completion tasks.
- **get_datasets/**: Scripts for downloading and preparing raw data.
- **method_generation_llms/** and **token_completion_llms/**: Contains training and evaluation scripts for method generation and token completion models, respectively.

You can find detailed information about each part in the corresponding directory.

## Getting Started

### Prerequisites

Ensure you have Python 3.8 or later installed, alongside pip for managing packages. 

To run the scripts in the get_datasets/ directory, you need to have Java JDK 17 installed. However, Java JDK 17 is not required for the rest of the repository

### Installation

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd <repository-name>
   ```

2. Install the required dependencies:
   ```bash
   pip install -r requirements.txt
   ```

## Usage

### Dataset Preparation

To prepare the datasets from a large Kotlin project:
1. Navigate to `get_datasets/kotlin/prepare_raw_data/`.
2. Run the script to download and prepare the dataset:
   ```bash
   bash download_and_create_archive.sh
   ```

### Dataset download

To download the datasets for Kotlin and Python, navigate to the respective directory and execute the following command:


```bash
bash download.sh
```

This script will retrieve all necessary files for your selected language and task.

### Model Training

To train the model on the Kotlin dataset:
1. Navigate to the appropriate training directory under `method_generation_llms/kotlin/train/` or `token_completion_llms/kotlin/train/`.
2. Run the training script:
   ```bash
   bash train_my_gpt_py.sh
   ```

### Model Evaluation

To evaluate the model:
1. Navigate to the evaluation directory in `method_generation_llms/kotlin/eval/` or `token_completion_llms/kotlin/eval/`.
2. Run the evaluation script:
   ```bash
   bash eval_kotlin_method_gen_gpt_py.sh
   ```

This will generate results and predictions that can be reviewed in the corresponding `results/` and `predictions/` directories.

## Results

For detailed results of training and evaluation, please refer to the README files located in the `token_completion_llms` and `method_generation_llms` directories.

All the models and datasets can be found [here](https://huggingface.co/iyubondyrev)