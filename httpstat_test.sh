#!/bin/bash

function httpstat() {
    echo "python httpstat.py $@"
    python httpstat.py $@
}

function httpstatpy3() {
    echo "python3 httpstat.py $@"
    python3 httpstat.py $@
}

function check_failed() {
    if [ $? -ne 0 ]; then
        echo Test failed
        exit 1
    fi
}

function runboth() {
    httpstat $@
    check_failed

    httpstatpy3 $@
    check_failed
}


runboth httpbin.org
runboth https://reorx.com
HTTPSTAT_SHOW_BODY="true" runboth "httpbin.org/get" -G --data-urlencode "a=中文" -v
HTTPSTAT_SHOW_BODY="true" runboth "httpbin.org/post" -X POST --data-urlencode "a=中文" -v
