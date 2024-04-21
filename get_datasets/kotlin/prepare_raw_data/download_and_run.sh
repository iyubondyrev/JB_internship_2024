# TODO: download GetPopularLiterals.jar

if [ ! -f "GetPopularLiterals.jar" ]; then
    echo "GetPopularLiterals.jar not found, downloading..."
    gdown 1iF2lODFziIEMlA3wquyYGSpjyLqWdPHs
else
    echo "GetPopularLiterals.jar already exists, skipping download."
fi

python3 create_archive.py

