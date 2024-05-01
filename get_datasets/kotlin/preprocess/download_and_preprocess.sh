Download the latest version of Preprocess.jar
curl -s https://api.github.com/repos/iyubondyrev/KotlinTokenizerJB/releases/latest \
| grep "browser_download_url" \
| grep "Preprocess.jar" \
| cut -d '"' -f 4 \
| wget -O Preprocess.jar -i -

TAR_FILE="kotlin_files.tar.gz"
TAR_ID=1uJyaJWGH3wurecY5M9QlTLEm7N_K4-RP

if [ ! -f "$TAR_FILE" ]; then
    echo "$TAR_FILE not found, downloading..."
    gdown $TAR_ID
else
    echo "$TAR_FILE already exists, skipping download."
fi

if [ ! -d "kotlin_data" ]; then
    if [ -f "$TAR_FILE" ]; then
        echo "Extracting $TAR_FILE..."
        tar -xzf "$TAR_FILE"
        echo "Extraction complete."
    else
        echo "Failed to locate $TAR_FILE after download attempt."
    fi
else
    echo "kotlin_data directory already exists, skipping extraction."
fi


# train
echo "Preprocess train."
python3 preprocess.py --base_dir="kotlin_data" --output_dir_token_completion="token_completion" --output_dir_method_generation="method_generation" --file_names='train_file_names.txt' --result_file_token_completion='train.txt' --result_file_method_generation='train.json' --literal_file_path='literals.json' --max_lines=1500 --tokens_threshold_to_parse=9000
echo "Done with train"
echo ""

# test
echo "Preprocess test."
python3 preprocess.py --base_dir="kotlin_data" --output_dir_token_completion="token_completion" --output_dir_method_generation="method_generation" --file_names='test_file_names.txt' --result_file_token_completion='test.txt' --result_file_method_generation='test.json' --literal_file_path='literals.json' --max_lines=1500 --tokens_threshold_to_parse=9000
echo "Done with test"
echo ""

# val
echo "Preprocess dev."
python3 preprocess.py --base_dir="kotlin_data" --output_dir_token_completion="token_completion" --output_dir_method_generation="method_generation" --file_names='validation_file_names.txt' --result_file_token_completion='dev.txt' --result_file_method_generation='dev.json' --literal_file_path='literals.json' --max_lines=1500 --tokens_threshold_to_parse=9000
echo "Done with dev"
echo ""