# TODO: download Tokenize.jar, kotlin_files.tar.gz

# Download the latest version of Tokenize.jar
curl -s https://api.github.com/repos/iyubondyrev/KotlinTokenizerJB/releases/latest \
| grep "browser_download_url" \
| grep "Tokenize.jar" \
| cut -d '"' -f 4 \
| wget -O Tokenize.jar -i -

TAR_FILE="kotlin_files.tar.gz"
TAR_ID=1FLdFBhqQVS-estT0OHHCy8SwI3JQ4gqA

if [ ! -f "$TAR_FILE" ]; then
    echo "$TAR_FILE not found, downloading..."
    gdown $TAR_ID
else
    echo "$TAR_FILE already exists, skipping download."
fi

if [ -f "$TAR_FILE" ]; then
    echo "Extracting $TAR_FILE..."
    tar -xzf "$TAR_FILE"
    echo "Extraction complete."
else
    echo "Failed to locate $TAR_FILE after download attempt."
fi

# train
java -jar Tokenize.jar --base_dir=kotlin_data --output_dir=token_completion --file_names='train_file_names.txt' --result_file='train.txt' --literal_file_path='literals.json'

# test
java -jar Tokenize.jar --base_dir=kotlin_data --output_dir=token_completion --file_names='test_file_names.txt' --result_file='test.txt' --literal_file_path='literals.json'

# val
java -jar Tokenize.jar --base_dir=kotlin_data --output_dir=token_completion --file_names='validation_file_names.txt' --result_file='validation.txt' --literal_file_path='literals.json'
