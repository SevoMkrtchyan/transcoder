#!/bin/bash
   
# script for check if transcoder wasn't started the stream, start it manually
   # check if url available
   response_c200=$(curl --write-out %{http_code} --silent --output /dev/null http://{hls_url}/c200/index.m3u8);
   
   DATE=$(date)
   
   echo -e "Script for check streams status was started at $DATE" | tee -a /var/log/transcoder.log
   
   if [ $response_c200 = 404 ]; then
      echo -e "$DATE c200 isn't started,checking process status or starting transcode process" | tee -a /var/log/transcoder.log
      var=$(ps aux | grep -c udp://220.0.0.1:5000)
      if [ $var = 2 ] ; then 
       echo -e "$DATE c200 process was started,waiting for source" | tee -a /var/log/transcoder.log        
       else
       ffmpeg -nostdin -hide_banner -nostats -loglevel panic -i udp://220.0.0.1:5000 -map_metadata 0 -pix_fmt yuv420p -vf yadif -s 1024:576 -sar 1:1 -aspect 16:9 -c:v libx264 -preset veryfast -crf 19 -q:v 0 -profile:v high -b:v 1500k -g 250 -bf 2 -keyint_min 25 -qmin 1 -i_qfactor 1.00 -color_primaries 1 -color_trc 1 -colorspace 1 -c:a aac -q:a 1 -ac 3 -b:a 192k -ar 48000 -f flv rtmp://localhost/show/c200 &
     echo -e "$DATE c200 transcode process was started" | tee -a /var/log/transcoder.log
	 fi 
	 fi
