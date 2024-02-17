#!/bin/bash

source ../../env.sh
module load darshan/3.4.4


REPORT_DIR=$1

LOG_DIR=/work/z19/z19/lparisi/courses/io/io_webinar/sw/darshan/darshan-logs/2024/2/9
darshan_file=$LOG_DIR/$(ls -la ${LOG_DIR}   | tail -n 1  | awk '{ print $9 }')
mkdir -p ${REPORT_DIR}
cd ${REPORT_DIR}
rm -f latest.darshan
cp $darshan_file latest.darshan
darshan-parser latest.darshan > summary.txt
darshan-dxt-parser latest.darshan > trace.txt
