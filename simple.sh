#!/bin/bash

ffmpeg -y -i a.mp4 -profile:v high -preset slow -b:v 500k -maxrate 500k -bufsize 1000k -threads 0 -filter:v "crop=1080:1080:420:0, scale=480:ih*480/iw" -pass 1 -an -f mp4 /dev/null

ffmpeg -y -i a.mp4 -profile:v high -preset slow -b:v 500k -maxrate 500k -bufsize 1000k -threads 0 -filter:v "crop=1080:1080:420:0, scale=480:ih*480/iw" -pass 2 -f mp4 b.mp4

MP4Box -inter 500 b.mp4