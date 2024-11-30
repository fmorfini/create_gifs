#!/bin/env bash

#loop through slices
# inputs
image=/Users/fmorfini/Downloads/anat_T1w.nii.gz
lastslice=96
firstslice=-50

# call fsleyes
echo "generating images from fsleyes. this takes a while"
for ((firstslice<$lastslice; firstslice++)); do
  output=$(printf "%03u" $z).png

# the first time to get this comand: open fsleyes, set up the views as you like manually, then [setting] [ortho view 1] [show command line for scene] copy and paste
fsleyes render -of $output --scene ortho --worldLoc 3.2318436975690474 -9.78085491242608 $z --displaySpace $image --xcentre  0.00000  0.00000 --ycentre  0.00000  0.00000 --zcentre  0.00000  0.00000 --xzoom 100.0 --yzoom 100.0 --zzoom 100.0 --hideLabels --layout horizontal --hidex --hidey --hideCursor --bgColour 0.0 0.0 0.0 --fgColour 1.0 1.0 1.0 --cursorColour 0.0 1.0 0.0 --colourBarLocation top --colourBarLabelSide top-left --colourBarSize 100.0 --labelSize 12 --performance 3 --movieSync $image --name "mybrain_desc-preproc_T1w" --overlayType volume --alpha 100.0 --brightness 50.0 --contrast 52.0 --cmap random --negativeCmap greyscale --displayRange 278.3576562500002 13639.52515625 --clippingRange 278.3576562500002 14057.061640625 --modulateRange 0.0 13917.8828125 --gamma -0.972916573745412 --cmapResolution 14 --interpolation spline --numSteps 100 --blendFactor 0.1 --smoothing 0 --resolution 100 --numInnerSteps 10 --clipMode intersection --volume 0

done

# or loop through volumes
# # inputs
# image=/Users/fmorfini/Downloads/func.nii.gz

# # call fsleyes
# echo "generating images from fsleyes. this takes a while"
# for vol in {37..52}; do
#   output=$(printf "%03u" $vol).png

# # the first time to get this comand: open fsleyes, set up the views as you like manually, then [setting] [ortho view 1] [show command line for scene] copy and paste
# fsleyes render -of $output --scene ortho --worldLoc -0.7163254690467511 77.84465164241178 21.327992795383786 --displaySpace ${image} --xcentre -0.00291  0.00469 --ycentre  0.00173  0.00479 --zcentre  0.00198 -0.00291 --xzoom 198.0 --yzoom 198.0 --zzoom 198.0 --showLocation no --layout horizontal --cursorWidth 1.0 --bgColour 0.0 0.0 0.0 --fgColour 1.0 1.0 1.0 --cursorColour 0.0 1.0 0.0 --colourBarLocation top --colourBarLabelSide top-left --colourBarSize 100.0 --labelSize 12 --performance 3 --movieSync /Users/franci/Downloads/noSTC_ICP017/noSTC_ICP017_r1.nii --name "noSTC_ICP017_r1" --overlayType volume --alpha 100.0 --brightness 49.74999999999999 --contrast 49.90029860765409 --cmap greyscale --negativeCmap greyscale --displayRange 0.0 3560.0999513423444 --clippingRange 0.0 3560.0999513423444 --modulateRange 0.0 3524.851436972618 --gamma 0.0 --cmapResolution 256 --interpolation none --numSteps 150 --blendFactor 0.1 --smoothing 0 --resolution 100 --numInnerSteps 10 --clipMode intersection --volume ${vol}

# done


#combine png into a gif
convert -delay 10 -loop 0 *.png tmp_movie.gif

#make background (black) transparent and trim border
convert tmp_movie.gif -transparent black -trim tmp_transp.gif

echo "generating gif"
#combine png into a gif, make background (black) transparent and trim border
convert -delay 10 -loop 0 -transparent black -trim -dispose previous  *.png tmp_movie.gif

#make cycle patrol (goes back and forth)
magick tmp_movie.gif -coalesce -duplicate 1,-2-1 -quiet -layers OptimizePlus -loop 0 Francesca_Morfini_my_brain_gif.gif 

mkdir allframes
mv *png tmp* allframes

echo "all done"
