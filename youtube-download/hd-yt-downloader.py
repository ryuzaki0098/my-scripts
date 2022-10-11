#!/bin/bash env python 

from pytube import Stream
from pytube import YouTube
from tqdm import tqdm


def progress_callback(stream: Stream, data_chunk: bytes, bytes_remaining: int) -> None:
    pbar.update(len(data_chunk))


url = input("enter url \n")
yt = YouTube(url, on_progress_callback=progress_callback)
stream = yt.streams.get_highest_resolution()
print(f"Downloading video to '{stream.default_filename}'")
pbar = tqdm(total=stream.filesize, unit="bytes")
path = stream.download()
pbar.close()
print(f"Saved video to {path}")

