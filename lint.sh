#!/bin/bash

pcregrep > /dev/null 2>&1
if [ $? -eq 127 ]; then
  echo "ERROR: You must install pcregrep"
  exit
fi

fail=0
directories="./_posts"

echo "Annoying characters to fix:"
pcregrep -ir --color='auto' -n '[^\x00-\x7F]' ${directories}
if [ "$?" -eq 0 ]; then
    fail=1
fi

echo "^M's:"
grep -ir $'\r' ${directories}
if [ "$?" -eq 0 ]; then
    fail=1
fi

echo "Use of FQDN links in posts or pages to fix (use post_url):"
grep -ir "(.*atopia\.net.*)" ${directories}
if [ "$?" -eq 0 ]; then
    fail=1
fi

if [ "$fail" -eq 0 ]; then
    echo "SUCCESS!"
else
    echo "Failure :("
fi
