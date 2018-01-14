#!/bin/bash
# Usage parse_log.sh caffe.log
# It creates the following two text files, each containing a table:
#     caffe.log.test (columns: '#Iters Seconds TestAccuracy TestLoss')
#     caffe.log.train (columns: '#Iters Seconds TrainingLoss LearningRate')


# get the dirname of the script
DIR="$( cd "$(dirname "$0")" ; pwd -P )"

if [ "$#" -lt 1 ]
then
    echo "Usage parse_log.sh /path/to/your.log"
    exit
fi
LOG=`basename $1`
sed -n '/Iteration .* Testing net/,/Iteration *. loss/p' $1 > aux.txt
sed -i.bak '/Waiting for data/d' aux.txt
sed -i.bak '/prefetch queue empty/d' aux.txt
sed -i.bak '/Iteration .* loss/d' aux.txt
sed -i.bak '/Iteration .* lr/d' aux.txt
sed -i.bak '/Train net/d' aux.txt
# FIXME extracting 2 times same iteration
grep 'Iteration ' aux.txt | sed  's/.*Iteration \([[:digit:]]*\).*/\1/g' | uniq > aux0.txt

# Test on train
grep -A3 'Testing net (#0)' aux.txt > aux_train.txt
grep 'Test net output #0' aux_train.txt | awk '{print $11}' > aux_train_acc1.txt
grep 'Test net output #1' aux_train.txt | awk '{print $11}' > aux_train_acc5.txt
grep 'Test net output #2' aux_train.txt | awk '{print $11}' > aux_train_loss.txt

# Test on test
grep -A3 'Testing net (#1)' aux.txt > aux_test.txt
grep 'Test net output #0' aux_test.txt | awk '{print $11}' > aux_test_acc1.txt
grep 'Test net output #1' aux_test.txt | awk '{print $11}' > aux_test_acc5.txt
grep 'Test net output #2' aux_test.txt | awk '{print $11}' > aux_test_loss.txt

# Extracting elapsed seconds
# For extraction of time since this line contains the start time

# Generating train acc
echo '#Iters TestAccuracy1 TestAccuracy5 TestLoss'> $LOG.test_on_train
paste aux0.txt aux_train_acc1.txt aux_train_acc5.txt aux_train_loss.txt | column -t >> $LOG.test_on_train
rm aux_train.txt aux_train_acc1.txt aux_train_acc5.txt aux_train_loss.txt

# Generating test acc
echo '#Iters TestAccuracy1 TestAccuracy5 TestLoss'> $LOG.test_on_test
paste aux0.txt aux_test_acc1.txt aux_test_acc5.txt aux_test_loss.txt | column -t >> $LOG.test_on_test
rm aux.txt aux_test.txt aux0.txt aux_test_acc1.txt aux_test_acc5.txt aux_test_loss.txt aux.txt.bak


# For extraction of time since this line contains the start time
grep '] Solving ' $1 > aux.txt
grep ', loss = ' $1 >> aux.txt
grep 'Iteration ' aux.txt | sed  's/.*Iteration \([[:digit:]]*\).*/\1/g' > aux0.txt
grep ', loss = ' $1 | awk '{print $9}' > aux1.txt
grep ', lr = ' $1 | awk '{print $9}' > aux2.txt

# Generating
echo '#Iters TrainingLoss LearningRate'> $LOG.train
paste aux0.txt aux1.txt aux2.txt | column -t >> $LOG.train
rm aux.txt aux0.txt aux1.txt aux2.txt
