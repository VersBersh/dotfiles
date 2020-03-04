#!/usr/bin/env sh

stderred_path="/usr/local/lib/libstderred.so"

if [ -f "$stderred_path" ]; then
    export LD_PRELOAD="$stderred_path${LD_PRELOAD:+:$LD_PRELOAD}"
fi

unset stderred_path

