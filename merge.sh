#!/bin/bash

CHAPTER=$1
SIZE=$2
TOTAL=`ls -l ./$CHAPTER | grep png | wc -l`
echo "Merging $CHAPTER chapter"
echo "Total source files: $TOTAL"

RESULTS=$(($TOTAL/$SIZE+1))
echo "Result files: $RESULTS"

ext="png"
dest="png"
counter=0
groups=()
for file in ./$CHAPTER/*.png; do
	index=$(($counter/$SIZE))
	cur=${groups[$index]}
	groups[$index]="$cur $file"
	counter=$(($counter + 1))
done

mkdir ./$CHAPTER/$dest

c=0
for list in "${groups[@]}"
do
   printf -v name "%03d" $c
   echo "Processing $name.$ext..."
   ~/magick convert -append $list "./$CHAPTER/$dest/$name.$ext"
   	c=$(($c + 1))
done

echo "Done."