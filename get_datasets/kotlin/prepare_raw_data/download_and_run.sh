# Download the latest version of GetPopularLiterals.jar
curl -s https://api.github.com/repos/iyubondyrev/KotlinTokenizerJB/releases/latest \
| grep "browser_download_url" \
| grep "GetPopularLiterals.jar" \
| cut -d '"' -f 4 \
| wget -O GetPopularLiterals.jar -i -

python3 create_archive.py

