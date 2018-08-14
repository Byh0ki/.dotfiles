#!/bin/bash

rectangles=" "

SR=$(xrandr --query | grep ' connected' | grep -o '[0-9][0-9]*x[0-9][0-9]*[^ ]*')
for RES in $SR; do
  SRA=(${RES//[x+]/ })
  CX=$((${SRA[2]} + 50))
  CY=$((${SRA[1]} - 30))
  rectangles+="rectangle $CX,$CY $((CX+300)),$((CY-80)) "
done

TMPBG=/tmp/screen.png
scrot $TMPBG && convert $TMPBG -scale 5% -scale 2000% -draw "fill black fill-opacity 0.4 $rectangles" $TMPBG


 letterEnteredColor=d23c3dff
 letterRemovedColor=d23c3dff
 passwordCorrect=00000000
 passwordIncorrect=d23c3dff
 background=00000000
 foreground=ffffffff
 i3lock \
  -t -i $TMPBG \
  --timepos="x+110:h-70" \
  --datepos="x+135:h-45" \
  --clock --datestr "Type password to unlock..." \
  --insidecolor=$background --ringcolor=$foreground --line-uses-inside \
  --keyhlcolor=$letterEnteredColor --bshlcolor=$letterRemovedColor --separatorcolor=$background \
  --insidevercolor=$passwordCorrect --insidewrongcolor=$passwordIncorrect \
  --ringvercolor=$foreground --ringwrongcolor=$foreground --indpos="x+280:h-65" \
  --radius=20 --ring-width=4 --veriftext="" --wrongtext="" \
  --verifcolor="$foreground" --timecolor="$foreground" --datecolor="$foreground" \
  --noinputtext="" --force-clock $lockargs


rm $TMPBG
