
# Get Datasets

This directory contains scripts to prepare datasets for token completion and method generation tasks, aligning with the format of CodeXGLUE datasets for [token completion](https://github.com/microsoft/CodeXGLUE/tree/main/Code-Code/CodeCompletion-token) and [method generation](https://github.com/microsoft/CodeXGLUE/tree/main/Code-Code/Method-Generation) tasks.

## Kotlin

### Prepare Raw Data

Located in `get_datasets/prepare_raw_data`, this script generates a .tar.gz archive containing all GitHub repositories used to fetch Kotlin (.kt) files. The archive includes all .kt files in the `/data` folder and a file `literals.json` with popular literals in the root folder. To generate this archive yourself, execute:

```bash
bash download_and_create_archive.sh
```

*Note*: Java JDK 17 is required to run this script.

This process involves downloading `GetPopularLiterals.jar` from the latest [release](https://github.com/iyubondyrev/KotlinTokenizerJB), and executing the `create_archive.py` script. The script clones all repositories listed [here](https://github.com/orgs/Kotlin/repositories?q=lang:kotlin&type=all) and [this repository](https://github.com/JetBrains/kotlin), extracts all .kt files, and uses `GetPopularLiterals.jar` to acquire popular literals. For further details, please see the code and visit [this repository](https://github.com/iyubondyrev/KotlinTokenizerJB).

### Preprocess

This folder contains a script to preprocess data fetched in the `prepare_raw_data` step. Execute the following command to preprocess the data:

```bash
bash download_and_preprocess.sh
```

*Note*: Java JDK 17 is required to run this script.

This process downloads [`kotlin_files.tar.gz`](https://drive.google.com/file/d/1uJyaJWGH3wurecY5M9QlTLEm7N_K4-RP/view?usp=drive_link) and `Preprocess.jar` from the latest [release](https://github.com/iyubondyrev/KotlinTokenizerJB), unpacks the archive, and runs `Preprocess.jar` on the files. Preprocessing is performed in chunks for robust execution, merging data from each chunk into one large file in the end. You will obtain two folders: `method_generation/` and `token_completion/`, containing train, test, and development sets for both tasks. For more details, see the scripts `download_and_preprocess.sh` and `preprocess.py`, and visit [this repo](https://github.com/iyubondyrev/KotlinTokenizerJB)

The `preprocess_python_example.py` script demonstrates how to preprocess Kotlin code using Python and ANTLR4, though it is not used for processing due to Python's speed limitations with large datasets.

### Example of Datasets

[Method Generation Example](https://huggingface.co/iyubondyrev/method_generation_kotlin)

[Token Completion Example](https://huggingface.co/iyubondyrev/token_completion_kotlin)

See the README in the /datasets folder for more details about these examples.

## Python

The Python code for preprocessing was taken from the corresponding part of the CodeXGLUE project. Further details can be found [here](https://github.com/microsoft/CodeXGLUE/tree/main/Code-Code). To download and prepare the dataset, execute:

```bash
bash download_and_extract.sh
```
