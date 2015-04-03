#!/bin/bash

count=`find /etc/ssl/private/ -type f -a -name \*.pem 2>/dev/null |wc -l`
if [ $count -eq 0 ]; then
   make-ssl-cert generate-default-snakeoil
   cat /etc/ssl/private/ssl-cert-snakeoil.key /etc/ssl/certs/ssl-cert-snakeoil.pem > /etc/ssl/private/server.pem
fi

export HTTP_IP="127.0.0.1"
export HTTP_PORT="80"
if [ "x${BACKEND_PORT}" != "x" ]; then
   HTTP_IP=`echo "${BACKEND_PORT}" | sed 's%/%%g' | awk -F: '{ print $2 }'`
   HTTP_PORT=`echo "${BACKEND_PORT}" | sed 's%/%%g' | awk -F: '{ print $3 }'`
fi

if [ "x${CIPHERS}" = "x" ]; then
   CIPHERS="ECDHE-RSA-AES128-SHA256:AES128-GCM-SHA256:RC4:HIGH:!MD5:!aNULL:!EDH"
fi

if [ "x${CORES}" = "x" ]; then
   CORES="1"
fi

/usr/local/bin/stud --write-xff -q -f '*,443' -b "${HTTP_IP},${HTTP_PORT}" -n ${CORES} `find /etc/ssl/private/ -type f -a -name \*.pem`
