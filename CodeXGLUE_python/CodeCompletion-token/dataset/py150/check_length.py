import os

""" all = 0
cnt = 0
with open("py150_files/python100k_train.txt", "r") as f:
    for path in f.readlines():
        f_path = os.path.join("py150_files/", path.strip())
        try:
            with open(f_path, "r", encoding="utf8") as py_f:
                if len(py_f.readlines()) > 1000:
                    cnt += 1
            all += 1
        except:
            pass

print(cnt / all) """


all = 0
cnt = 0
with open("token_completion/test.txt", "r") as f:
    for line in f:
        line = line.split()
        eol_cnt = line.count("<EOL>")
        if eol_cnt > 6000:
            cnt += 1
        all += 1

print(cnt / all) 