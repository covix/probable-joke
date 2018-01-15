#!/bin/bash
# Usage parse_log.sh caffe.log
# It creates the following two text files, each containing a table:
#     caffe.log.test (columns: '#Iters Seconds TestAccuracy TestLoss')
#     caffe.log.train (columns: '#Iters Seconds TrainingLoss LearningRate')


# get the dirname of the script
DIR="$( cd "$(dirname "$0")" ; pwd -P )"
LOG_DIR='logs'

mkdir -p $LOG_DIR

if [ "$#" -lt 1 ]
then
    echo "Usage parse_log.sh /path/to/your.log"
    exit
fi
LOG=`basename $1`
sed -n '/Iteration .* Testing net/,/Iteration *. loss/p' $1 > ${LOG_DIR}/LOG.aux.txt
sed -i.bak '/Waiting for data/d' ${LOG_DIR}/LOG.aux.txt
sed -i.bak '/prefetch queue empty/d' ${LOG_DIR}/LOG.aux.txt
sed -i.bak '/Iteration .* loss/d' ${LOG_DIR}/LOG.aux.txt
sed -i.bak '/Iteration .* lr/d' ${LOG_DIR}/LOG.aux.txt
sed -i.bak '/Train net/d' ${LOG_DIR}/LOG.aux.txt
# FIXME extracting 2 times same iteration
grep 'Iteration ' ${LOG_DIR}/LOG.aux.txt | sed  's/.*Iteration \([[:digit:]]*\).*/\1/g' | uniq > ${LOG_DIR}/LOG.aux0.txt

# Test on train
grep -A3 'Testing net (#0)' ${LOG_DIR}/LOG.aux.txt > ${LOG_DIR}/LOG.aux_train.txt
grep 'Test net output #0' ${LOG_DIR}/LOG.aux_train.txt | awk '{print $11}' > ${LOG_DIR}/LOG.aux_train_acc1.txt
grep 'Test net output #1' ${LOG_DIR}/LOG.aux_train.txt | awk '{print $11}' > ${LOG_DIR}/LOG.aux_train_acc5.txt
grep 'Test net output #2' ${LOG_DIR}/LOG.aux_train.txt | awk '{print $11}' > ${LOG_DIR}/LOG.aux_train_loss.txt

# Test on test
grep -A3 'Testing net (#1)' ${LOG_DIR}/LOG.aux.txt > ${LOG_DIR}/LOG.aux_test.txt
grep 'Test net output #0' ${LOG_DIR}/LOG.aux_test.txt | awk '{print $11}' > ${LOG_DIR}/LOG.aux_test_acc1.txt
grep 'Test net output #1' ${LOG_DIR}/LOG.aux_test.txt | awk '{print $11}' > ${LOG_DIR}/LOG.aux_test_acc5.txt
grep 'Test net output #2' ${LOG_DIR}/LOG.aux_test.txt | awk '{print $11}' > ${LOG_DIR}/LOG.aux_test_loss.txt

# Extracting elapsed seconds
# For extraction of time since this line contains the start time

# Generating train acc
echo '#Iters TestAccuracy1 TestAccuracy5 TestLoss'> ${LOG_DIR}/$LOG.test_on_train
paste ${LOG_DIR}/LOG.aux0.txt ${LOG_DIR}/LOG.aux_train_acc1.txt ${LOG_DIR}/LOG.aux_train_acc5.txt ${LOG_DIR}/LOG.aux_train_loss.txt | column -t >> ${LOG_DIR}/$LOG.test_on_train
rm ${LOG_DIR}/LOG.aux_train.txt ${LOG_DIR}/LOG.aux_train_acc1.txt ${LOG_DIR}/LOG.aux_train_acc5.txt ${LOG_DIR}/LOG.aux_train_loss.txt

# Generating test acc
echo '#Iters TestAccuracy1 TestAccuracy5 TestLoss'> ${LOG_DIR}/$LOG.test_on_test
paste ${LOG_DIR}/LOG.aux0.txt ${LOG_DIR}/LOG.aux_test_acc1.txt ${LOG_DIR}/LOG.aux_test_acc5.txt ${LOG_DIR}/LOG.aux_test_loss.txt | column -t >> ${LOG_DIR}/$LOG.test_on_test
rm ${LOG_DIR}/LOG.aux.txt ${LOG_DIR}/LOG.aux_test.txt ${LOG_DIR}/LOG.aux0.txt ${LOG_DIR}/LOG.aux_test_acc1.txt ${LOG_DIR}/LOG.aux_test_acc5.txt ${LOG_DIR}/LOG.aux_test_loss.txt ${LOG_DIR}/LOG.aux.txt.bak


# For extraction of time since this line contains the start time
grep '] Solving ' $1 > ${LOG_DIR}/LOG.aux.txt
grep ', loss = ' $1 >> ${LOG_DIR}/LOG.aux.txt
grep 'Iteration ' ${LOG_DIR}/LOG.aux.txt | sed  's/.*Iteration \([[:digit:]]*\).*/\1/g' > ${LOG_DIR}/LOG.aux0.txt
grep ', loss = ' $1 | awk '{print $9}' > ${LOG_DIR}/LOG.aux1.txt
grep ', lr = ' $1 | awk '{print $9}' > ${LOG_DIR}/LOG.aux2.txt

# Generating
echo '#Iters TrainingLoss LearningRate'> ${LOG_DIR}/$LOG.train
paste ${LOG_DIR}/LOG.aux0.txt ${LOG_DIR}/LOG.aux1.txt ${LOG_DIR}/LOG.aux2.txt | column -t >> ${LOG_DIR}/$LOG.train
rm ${LOG_DIR}/LOG.aux.txt ${LOG_DIR}/LOG.aux0.txt ${LOG_DIR}/LOG.aux1.txt ${LOG_DIR}/LOG.aux2.txt
