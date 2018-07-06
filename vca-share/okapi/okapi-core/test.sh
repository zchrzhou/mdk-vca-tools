#!/bin/bash

## source whoami.sh
. /zach/lib/whoami.sh 

pushd $VCASHARE_ROOT/perf-script/binary/linux

## h264 -> h264
./sample_multi_transcode_drm -hw -i::h264 $VCASHARE_ROOT/run/test/water.h264 -o::h264 $VCASHARE_ROOT/run/test/output.h264

popd
