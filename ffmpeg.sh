#!/bin/sh

# Set default resolution if none specified
if [ -z $IW ]; then IW=1920; fi
if [ -z $IH ]; then IH=1080; fi

if [ -z $OUTPATH ]; then OUTPATH="."; fi

IN=Source/$EVENT/$REEL/$INFILE
OUT=$EVENT-$REEL-$TAKE.mov

# ffmpeg-relevant config
FILTER="crop=iw:iw/($IW/$IH):0:(ih/2)-((iw/($IW/$IH))/2),setdar=dar=16/9,setsar=1:1"
FPS=24
PIXFMT=yuv444p10

echo ""
echo "Event: $EVENT\tReel: $REEL/$TAKE\tResolution: $IW*$IH"
echo "Infile: $INFILE\t->\tOutfile: $OUTFILE"
echo "Filter args:\t\t$FILTER"

echo "Infile:\t\t$IN"
echo "Outfile:\t$(pwd)/$OUTFILE"
echo ""

ffmpeg -f image2 -pattern_type glob \
	-i "$IN" -framerate $FPS \
	-vf $FILTER -an -r $FPS \
	-vcodec prores -profile:v 2 -pix_fmt $PIXFMT \
	$(pwd)/$OUT
