#!/bin/bash

# encode each clip to a standard mp4, with crop and resize
ffmpeg -y -i a.mov -profile:v high -preset slow -b:v 500k -maxrate 500k -r 29.97 -bufsize 1000k -threads 0  -filter:v "scale=-1:480" -filter:v "crop=480:480" -pass 1 -an -f mp4 /dev/null

ffmpeg -y -i a.mov -profile:v high -preset slow -b:v 500k -maxrate 500k -r 29.97 -bufsize 1000k -threads 0  -filter:v "scale=-1:480" -filter:v "crop=480:480" -pass 2 -f mp4 a.mp4

 ffmpeg -y -i b.mov -profile:v high -preset slow -b:v 500k -maxrate 500k -r 29.97 -bufsize 1000k -threads 0 -filter:v "scale=-1:480" -filter:v "crop=480:480" -pass 1 -an -f mp4 /dev/null

ffmpeg -y -i b.mov -profile:v high -preset slow -b:v 500k -maxrate 500k -r 29.97 -bufsize 1000k -threads 0 -filter:v "scale=-1:480" -filter:v "crop=480:480" -pass 2 -f mp4 b.mp4

 ffmpeg -y -i c.mov -profile:v high -preset slow -b:v 500k -maxrate 500k -r 29.97 -bufsize 1000k -threads 0 -filter:v "scale=-1:480" -filter:v "crop=480:480" -pass 1 -an -f mp4 /dev/null

ffmpeg -y -i c.mov -profile:v high -preset slow -b:v 500k -maxrate 500k -r 29.97 -bufsize 1000k -threads 0 -filter:v "scale=-1:480" -filter:v "crop=480:480" -pass 2 -f mp4 c.mp4

 ffmpeg -y -i d.mov -profile:v high -preset slow -b:v 500k -maxrate 500k -r 29.97 -bufsize 1000k -threads 0 -filter:v "scale=-1:480" -filter:v "crop=480:480" -pass 1 -an -f mp4 /dev/null

ffmpeg -y -i d.mov -profile:v high -preset slow -b:v 500k -maxrate 500k -r 29.97 -bufsize 1000k -threads 0 -filter:v "scale=-1:480" -filter:v "crop=480:480" -pass 2 -f mp4 d.mp4

 ffmpeg -y -i e.mov -profile:v high -preset slow -b:v 500k -maxrate 500k -r 29.97 -bufsize 1000k -threads 0 -filter:v "scale=-1:480" -filter:v "crop=480:480" -pass 1 -an -f mp4 /dev/null

ffmpeg -y -i e.mov -profile:v high -preset slow -b:v 500k -maxrate 500k -r 29.97 -bufsize 1000k -threads 0 -filter:v "scale=-1:480" -filter:v "crop=480:480" -pass 2 -f mp4 e.mp4

 ffmpeg -y -i f.mov -profile:v high -preset slow -b:v 500k -maxrate 500k -r 29.97 -bufsize 1000k -threads 0 -filter:v "scale=-1:480" -filter:v "crop=480:480" -pass 1 -an -f mp4 /dev/null

ffmpeg -y -i f.mov -profile:v high -preset slow -b:v 500k -maxrate 500k -r 29.97 -bufsize 1000k -threads 0 -filter:v "scale=-1:480" -filter:v "crop=480:480" -pass 2 -f mp4 f.mp4


# convert to intermediary ts format
ffmpeg -y -i a.mp4 -c copy -bsf h264_mp4toannexb a.ts

ffmpeg -y -i b.mp4 -c copy -bsf h264_mp4toannexb b.ts

ffmpeg -y -i c.mp4 -c copy -bsf h264_mp4toannexb c.ts

ffmpeg -y -i d.mp4 -c copy -bsf h264_mp4toannexb d.ts

ffmpeg -y -i e.mp4 -c copy -bsf h264_mp4toannexb e.ts

ffmpeg -y -i f.mp4 -c copy -bsf h264_mp4toannexb f.ts


# do concatenation
rm g.ts
cat a.ts b.ts c.ts d.ts e.ts f.ts > g.ts

# convert back to mp4
ffmpeg -y -i g.ts -c copy -bsf:a aac_adtstoasc final.mp4

# optimize for web playback
MP4Box -inter 500 final.mp4