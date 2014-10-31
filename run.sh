#!/bin/bash

ffmpeg -y -i a.mov -profile:v high -preset slow -b:v 500k -maxrate 500k -bufsize 1000k -threads 0 -filter:v "crop=480:480:0:80" -pass 1 -an -f mp4 /dev/null

ffmpeg -y -i a.mov -profile:v high -preset slow -b:v 500k -maxrate 500k -bufsize 1000k -threads 0 -filter:v "crop=480:480:0:80" -pass 2 -f mp4 a.mp4

 ffmpeg -y -i b.mov -profile:v high -preset slow -b:v 500k -maxrate 500k -bufsize 1000k -threads 0 -filter:v "crop=480:480:0:80" -pass 1 -an -f mp4 /dev/null

ffmpeg -y -i b.mov -profile:v high -preset slow -b:v 500k -maxrate 500k -bufsize 1000k -threads 0 -filter:v "crop=480:480:0:80" -pass 2 -f mp4 b.mp4

ffmpeg -y -i a.mp4 -c copy -bsf h264_mp4toannexb a.ts

ffmpeg -y -i b.mp4 -c copy -bsf h264_mp4toannexb b.ts

rm c.ts
cat a.ts b.ts > c.ts

ffmpeg -y -i c.ts -c copy -bsf:a aac_adtstoasc final.mp4

MP4Box -inter 500 final.mp4