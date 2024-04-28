# Download the latest version of Preprocess.jar
#curl -s https://api.github.com/repos/iyubondyrev/KotlinTokenizerJB/releases/latest \
#| grep "browser_download_url" \
#| grep "Preprocess.jar" \
#| cut -d '"' -f 4 \
#| wget -O Preprocess.jar -i -

TAR_FILE="kotlin_files.tar.gz"
TAR_ID=1FLdFBhqQVS-estT0OHHCy8SwI3JQ4gqA

if [ ! -f "$TAR_FILE" ]; then
    echo "$TAR_FILE not found, downloading..."
    gdown $TAR_ID
else
    echo "$TAR_FILE already exists, skipping download."
fi

#if [ -f "$TAR_FILE" ]; then
#    echo "Extracting $TAR_FILE..."
#    tar -xzf "$TAR_FILE"
#    echo "Extraction complete."
#else
#    echo "Failed to locate $TAR_FILE after download attempt."
#fi

# train
java -jar Preprocess.jar --base_dir="kotlin_data" --output_dir_token_completion="token_completion" --output_dir_method_generation="method_generation" --file_names='train_file_names.txt' --result_file_token_completion='train.txt' --result_file_method_generation='train.json' --literal_file_path='literals.json' 2>/dev/null

# test
java -jar Preprocess.jar --base_dir="kotlin_data" --output_dir_token_completion="token_completion" --output_dir_method_generation="method_generation" --file_names='test_file_names.txt' --result_file_token_completion='test.txt' --result_file_method_generation='test.json' --literal_file_path='literals.json' 2>/dev/null

# val
java -jar Preprocess.jar --base_dir="kotlin_data" --output_dir_token_completion="token_completion" --output_dir_method_generation="method_generation" --file_names='validation_file_names.txt' --result_file_token_completion='dev.txt' --result_file_method_generation='dev.json' --literal_file_path='literals.json' 2>/dev/null
