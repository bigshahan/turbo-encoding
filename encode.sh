#!/bin/bash

# encode each clip to a standard mp4, with crop and resize
ffmpeg -y -i a.mp4 -profile:v high -preset slow -b:v 500k -maxrate 500k -r 29.97 -bufsize 1000k -threads 0  -filter:v "scale=-1:480" -filter:v "crop=480:480" -pass 1 -an -f mp4 /dev/null

ffmpeg -y -i a.mp4 -profile:v high -preset slow -b:v 500k -maxrate 500k -r 29.97 -bufsize 1000k -threads 0  -filter:v "scale=-1:480" -filter:v "crop=480:480" -pass 2 -f mp4 b.mp4