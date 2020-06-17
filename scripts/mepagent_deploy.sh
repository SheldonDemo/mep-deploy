#!/bin/bash

echo "MEP_IP should set be the host ip!"

set +o history
# initial variables
set +x
source scripts/mep_vars.sh
set -x

# deploy mepagent
docker run -itd --name mepagent \
                -e MEP_IP=10.151.154.36 \
                -e MEP_APIGW_PORT=8443 \
                -e MEP_AUTH_ROUTE=mepauth \
                -e ENABLE_WAIT=true \
                -e "CA_CERT=/etc/mepssl/ca.crt" \
                -e "CA_CERT_DOMAIN_NAME=${DOMAIN_NAME}" \
                -v ${CACRT_PATH}:/etc/mepssl/ca.crt:ro \
                -v app_instance_info.yaml:/usr/app/conf/app_instance_info.yaml:ro \
                -v app_conf.yaml:/usr/app/conf/app_conf.yaml:ro \
                edgegallery/mep-agent:latest -ak ${ACCESS_KEY} -sk ${SECRET_KEY}
set -o history
