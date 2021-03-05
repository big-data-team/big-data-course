#!/usr/bin/env python3
import sys

for line in sys.stdin:
    article_id, content = line.split("\t", 1)
    words = content.split()
    for word in words:
        if word:
            print(word, 1, sep="\t")

