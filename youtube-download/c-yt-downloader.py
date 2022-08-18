#!/bin/bash env python

import pytube

from pytube import YouTube

def download_video(url):
    yt = YouTube(url)
    videos = yt.streams.all()
    video = list(enumerate(videos))
    for i in video:
        print(i)

    print("chhose the format to download")
    download_format = int(input("choose the format number :"))
    videos[download_format].download()
    print("video downloaded")

if __name__ == "__main__":
    url = input("enter the url of the video :")
    download_video(url)
    print("video downloaded")
    main()
    exit()
