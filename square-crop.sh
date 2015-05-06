#!/bin/bash

# clean up
rm *.ts *.2.mp4 ffmpeg2* final.mp4

# encode each clip to a standard mp4, with crop and resize
declare -a arr=("a" "b" "c" "d" "e" "f" "g", "h")

for i in "${arr[@]}"
do
	# normalize to standard mp4

	echo Transcoding_$i

	line=$(exiftool -Rotation $i.mp4)
	rotation=${line#*:}

	echo $rotation

	ffmpeg -y -i $i.mp4 -profile:v high -preset slow -b:v 500k -maxrate 500k -r 29.97 -bufsize 1000k -threads 0 -c:a libfdk_aac -ar 44100 -ac 1 -b:a 64k -filter:v "scale='if(gt(a,1),-1,480)':'if(gt(a,1),480,-1)',crop=480:480,rotate=$rotation*PI/180" -pass 1 -an -f mp4 /dev/null
	ffmpeg -y -i $i.mp4 -profile:v high -preset slow -b:v 500k -maxrate 500k -r 29.97 -bufsize 1000k -threads 0 -c:a libfdk_aac -ar 44100 -ac 1 -b:a 64k -filter:v "scale='if(gt(a,1),-1,480)':'if(gt(a,1),480,-1)',crop=480:480,rotate=$rotation*PI/180" -pass 2 -f mp4 $i.2.mp4
	
	# intermediary ts format
	ffmpeg -y -i $i.2.mp4 -c copy -bsf h264_mp4toannexb $i.ts
done

# do concatenation
cat a.ts b.ts c.ts d.ts e.ts f.ts g.ts h.ts > i.ts

# convert back to mp4
ffmpeg -y -i i.ts -c copy -bsf:a aac_adtstoasc final.mp4

# optimize for web playback
MP4Box -inter 500 final.mp4

# cleanup
# rm *.ts *.2.mp4 ffmpeg2*