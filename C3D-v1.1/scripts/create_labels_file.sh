DATAFOLDER=$1

for i in `ls $DATAFOLDER`
do
	# Get the 3rd component of the name that is the class label
	CLASS_LABEL=`basename $i | cut -d- -f 3`
	echo $i $CLASS_LABEL
done
