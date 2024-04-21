import requests
import subprocess
import os
import shutil
import random
import tarfile
from typing import List

def setup_directory(base_dir):
    if not os.path.exists(base_dir):
        os.makedirs(base_dir)
    os.chdir(base_dir)

def delete_directory(dir_path: str) -> None:
    if os.path.exists(dir_path):
        shutil.rmtree(dir_path)

def delete_files(files: List[str]) -> None:
    for file in files:
        if os.path.exists(file):
            os.remove(file)


def get_repo_urls(base_url: str):
    response = requests.get(base_url)
    if response.status_code == 200:
        data = response.json()
        github_url = "https://github.com/"
        repo_urls = [github_url + repo["owner"] + "/" + repo["name"] + ".git" for repo in data["payload"]["repositories"]]
        return repo_urls
    else:
        print("Failed to fetch data: HTTP Status Code", response.status_code)
        return []

def clone_repositories(repo_urls: List[str], directory='kotlin_repos'):
    if not os.path.exists(directory):
        os.makedirs(directory)
    os.chdir(directory)
    for url in repo_urls:
        print(f'Cloning {url}')
        subprocess.run(['git', 'clone', url], check=True)
    os.chdir('..')

def copy_kotlin_files(source_dir: str, dir_with_all_files: str, file_with_all_names: str) -> None:
    if not os.path.exists(dir_with_all_files):
        os.makedirs(dir_with_all_files)
    
    filenames = []
    for root, dirs, files in os.walk(source_dir):
        for file in files:
            if file.endswith('.kt'):
                source_file = os.path.join(root, file)
                # we will not take files that are longer than 5000 lines,
                # because lexer dies on them
                # even offical kotlin lexer sometimes takes too long
                # the number of the files that are longer than 5000 is ~0.1% of all the files, so it is ok
                with open(source_file, "r") as sf:
                    if (len(sf.readlines())) > 5000:
                        continue
                target_file = os.path.join(dir_with_all_files, file)
                shutil.copy2(source_file, target_file)
                filenames.append(file)

    filenames = list(set(filenames)) # no duplicates

    with open(file_with_all_names, 'w') as f:
        f.writelines(f"{dir_with_all_files}/{filename}\n" for filename in filenames)

    
    
def create_test_train_split(file_with_all_files: str, file_with_bad_files: str) -> None:
    with open(file_with_all_files, "r") as f:
        all_filenames = f.read().splitlines()
    
    with open(file_with_bad_files, "r") as f:
        bad_filenames = f.read().splitlines()


    filenames = list(set(all_filenames).difference(set(bad_filenames)))

    random.seed(42)
    random.shuffle(filenames)

    total_files = len(filenames)
    train_end = int(total_files * 0.8)
    test_end = train_end + int(total_files * 0.15)

    train_files = filenames[:train_end]
    test_files = filenames[train_end:test_end]
    validation_files = filenames[test_end:]

    for filename in filenames:
        assert os.path.exists(filename)


    with open('train_file_names.txt', 'w') as f:
        f.writelines(f"{filename}\n" for filename in train_files)

    with open('test_file_names.txt', 'w') as f:
        f.writelines(f"{filename}\n" for filename in test_files)

    with open('validation_file_names.txt', 'w') as f:
        f.writelines(f"{filename}\n" for filename in validation_files)
    

def create_tar_gz_archive(archive_folder, archive_name):
    with tarfile.open(archive_name, "w:gz") as tar:
        tar.add(archive_folder)

def main():
    archive_folder = "kotlin_data"
    setup_directory(archive_folder)

    first_page = 'https://github.com/orgs/Kotlin/repositories?q=lang:kotlin&type=all'
    repo_urls = get_repo_urls(first_page)
    second_page = "https://github.com/orgs/Kotlin/repositories?q=lang%3Akotlin&type=all&page=2"
    repo_urls += get_repo_urls(second_page)
    repo_urls = ["https://github.com/JetBrains/kotlin"] + repo_urls
    clone_repositories(repo_urls)
    print("DONE WITH CLONING REPOSES")

    source_directory = 'kotlin_repos'
    dir_with_all_files = 'data'
    list_file_path = 'file_names.txt'
    copy_kotlin_files(source_directory, dir_with_all_files, list_file_path)
    print("DONE WITH GETTING .kt FILES")


    # Running GetPopularLiterals.jar
    file_names = "file_names.txt"
    output_literal = "literals.json"
    output_bad = "bad_files.txt"

    print("Running GetPopularLiterals.jar...")
    subprocess.run([
        'java', '-jar', '../GetPopularLiterals.jar',
        '--base_dir=' + "",
        '--file_names=' + file_names,
        '--literal_file=' + output_literal,
        '--bad_file=' + output_bad
    ], check=True)
    print("DONE WITH GETTING POPULAR LITERALS")

    create_test_train_split(list_file_path, output_bad)

    delete_files([output_bad, file_names])

    os.chdir("..")

    # Continue with creating archive and cleanup
    archive_filename = 'kotlin_files.tar.gz'
    create_tar_gz_archive(archive_folder, archive_filename)
    print("DONE CREATING ARCHIVE")

    delete_directory(archive_folder)
    print("CLEANUP COMPLETE. ONLY .tar.gz REMAINS")

if __name__ == "__main__":
    main()
