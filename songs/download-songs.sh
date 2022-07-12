#!/bin/bash 

echo "specify link of song"
read link
echo "specify name of song with no spaces"
read name
youtube-dl -x --audio-format mp3 $link -o $name.mp3
