#!/bin/bash

# Start transcoder
ffmpeg -nostdin -hide_banner -nostats -loglevel panic -i udp://222.0.0.1:5000 -map_metadata 0 -pix_fmt yuv420p -vf yadif -s 1024:576 -sar 1:1 -aspect 16:9 -c:v libx264 -preset veryfast -crf 19 -q:v 0 -profile:v high -b:v 1500k -g 250 -bf 2 -keyint_min 25 -qmin 1 -i_qfactor 1.00 -color_primaries 1 -color_trc 1 -colorspace 1 -c:a aac -q:a 1 -ac 3 -b:a 192k -ar 48000 -f flv rtmp://localhost/show/c200 &
