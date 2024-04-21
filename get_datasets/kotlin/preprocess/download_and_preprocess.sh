# TODO: download Tokenize.jar, kotlin_files.tar.gz


if [ ! -f "Tokenize.jar" ]; then
    echo "Tokenize.jar not found, downloading..."
    gdown 1gdYlWo6nNz6g_I_NCFyNOLfzakLJuMGx
else
    echo "Tokenize.jar already exists, skipping download."
fi

TAR_FILE="kotlin_files.tar.gz"
GD_DOWNLOAD_LINK="" 

if [ ! -f "$TAR_FILE" ]; then
    echo "$TAR_FILE not found, downloading..."
    gdown "$GD_DOWNLOAD_LINK" -O "$TAR_FILE"
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