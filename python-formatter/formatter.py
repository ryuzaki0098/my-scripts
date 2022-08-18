#!/bin/bash env python

import os
import sys
import black


def format_code(file_path):
    with open(file_path, "r") as f:
        code = f.read()
        formatted_code = black.format_str(code, mode=black.FileMode())
        with open(file_path, "w") as f:
            f.write(formatted_code)

def save_file(file_path, content):
    with open(file_path, "w") as f:
        f.write(content)

def format_all_files(path):
    for root, dirs, files in os.walk(path):
        for file in files:
            if file.endswith(".py"):
                file_path = os.path.join(root, file)
                format_code(file_path)
                print("Formatted {}".format(file_path))


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python formatter.py <path> > output_file*.py")
        sys.exit(1)
    path = sys.argv[1]
    format_all_files(path)
    print("Formatted all files in {}".format(path))
    sys.exit(0)

    

