
# Datasets

This directory contains scripts for downloading datasets for Python and Kotlin, aimed at method generation and token completion tasks. The Kotlin datasets were generated using scripts in the `get_datasets/` folder. [Here](https://drive.google.com/file/d/1uJyaJWGH3wurecY5M9QlTLEm7N_K4-RP/view?usp=sharing) is a link to the archive containing raw Kotlin files used to produce these datasets. Note that the archive was created on 23.04.2024, and recreating it using the script in `get_datasets/prepare_raw_data` might yield different results due to the dynamic nature of the data sources on GitHub.

For additional details on the Kotlin datasets, visit [this page](https://github.com/iyubondyrev/KotlinTokenizerJB/tree/main), which describes the tool used to acquire these datasets, and see readme in `get_datasets/`

The scripts for the Python language download only the test part of the corresponding dataset.

## Token Completion

### Kotlin

The dataset format is as follows:

```text
<s> tokenized code with literal normalization <\s>
```

This format aligns with the datasets for token completion used in the CodeXGLUE project. More information about this format can be found [here](https://github.com/microsoft/CodeXGLUE/tree/main/Code-Code/CodeCompletion-token).

The dataset is available [here](https://huggingface.co/iyubondyrev/token_completion_kotlin).

### Python

This dataset was obtained using the code available [here](https://github.com/microsoft/CodeXGLUE/tree/main/Code-Code/CodeCompletion-token), and can be accessed [here](https://huggingface.co/iyubondyrev/token_completion_python).

## Method Generation

### Kotlin

The dataset format is a `.jsonl` file, where each line is a JSON object with the following fields:

```json
{
    "signature": "",
    "body": "",
    "docstring": ""
}
```

You can find the dataset [here](https://huggingface.co/iyubondyrev/method_generation_kotlin). It includes two versions: one is 'full' and the other 'with docstrings'. The 'full' dataset contains all functions extracted from the raw data, while the 'with docstrings' version only includes functions that have a docstring. You can choose which version to download by setting the following in the `datasets/method_generation_dataset/kotlin/download.sh` file:

```bash
FULL=false # or true
```

### Python

This dataset, from the CodeXGLUE project, is available [here](https://huggingface.co/datasets/microsoft/codexglue_method_generation). Further details about this dataset can be found [here](https://github.com/microsoft/CodeXGLUE/tree/main/Code-Code/Method-Generation).
