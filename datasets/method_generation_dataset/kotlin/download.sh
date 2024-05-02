FULL=false

if [ "$FULL" = "true" ]; then
    echo "Downloading full datasets..."
    curl -L https://huggingface.co/iyubondyrev/method_generation_kotlin/resolve/main/train_full.jsonl?download=true -o train.jsonl
    curl -L https://huggingface.co/iyubondyrev/method_generation_kotlin/resolve/main/test_full.jsonl?download=true -o test.jsonl
    curl -L https://huggingface.co/iyubondyrev/method_generation_kotlin/resolve/main/dev_full.jsonl?download=true -o dev.jsonl
else
    echo "Downloading datasets with docstrings..."
    curl -L https://huggingface.co/iyubondyrev/method_generation_kotlin/resolve/main/train_with_docstring.jsonl?download=true -o train.jsonl
    curl -L https://huggingface.co/iyubondyrev/method_generation_kotlin/resolve/main/test_with_docstring.jsonl?download=true -o test.jsonl
    curl -L https://huggingface.co/iyubondyrev/method_generation_kotlin/resolve/main/dev_with_docstring.jsonl?download=true -o dev.jsonl
fi
