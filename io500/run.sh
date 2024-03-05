module load reframe

export RFM_IGNORE_REQNODENOTAVAIL=true

for i in {1..10}
do
    filename_report=`date +%d-%m-%Y_%H.%M`.json
    report_dir="/work/z04/z04/lparisi/e1000_benchmarking/filesystem_benchmarks/results/cirrus-e1000/io500/reports"
    #report_dir="/work/z04/shared/reframe_io/23-10-23/1Node36tpn/unstriped/reports"
    mkdir -p $report_dir
    reframe -C cirrus_settings.py -v -R -c io500/ --name io500 -r -J "exclusive" -J "qos=reservation" -J "account=z04" -J "reservation=cse-ipa" --report-file ${report_dir}/$filename_report
done
