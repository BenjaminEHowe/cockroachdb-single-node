#!/bin/sh

echo "**** Starting single cockroach node..."

if [[ -n "$MEMORY_SIZE" ]];
then
  ./cockroach start-single-node --insecure --log-config-file=logs.yaml --cache=.25 --background --store=type=mem,size=${MEMORY_SIZE}
else
  ./cockroach start-single-node --insecure --log-config-file=logs.yaml --cache=.25 --background
fi

echo "**** Setting optimizations"

./cockroach sql --insecure --file optimizations.sql

cd /cockroach/cockroach-data/logs
tail -f cockroach.log
