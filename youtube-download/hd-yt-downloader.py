#!/bin/bash env python

from typing import List

import pytube
from pytube import YouTube
import os
def download_video(url):
    yt = YouTube(url)
    video = yt.streams.get_highest_resolution()  
    print("Video downloaded")
    video.download()

def main():
    url = input("Enter the url of the video: ")
    download_video(url)

if __name__ == "__main__":
    main()
