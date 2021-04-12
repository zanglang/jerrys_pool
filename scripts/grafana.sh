#!/bin/bash
set -x

DIR=$(dirname "$0")
source ${DIR}/env.sh

BASE_URL="https://zanglang.grafana.net/render/d-solo/"
ARGS="orgId=1&width=1000&height=500&tz=UTC"

generate() {
    if ! timeout 30 curl -H "${AUTH}" -s "${BASE_URL}${1}&${ARGS}" > "${2}"; then
        rm -f "${2}" &>/dev/null
    fi
}

cd "${DIR}"
#generate "_vb4ur_gz/nodes?panelid=2" "cpu.png"
#generate "_vb4ur_gz/nodes?panelid=7" "disk.png"
generate "UJyurCTWz/chain-dashboard?panelId=75" "votingpower.png"
generate "UJyurCTWz/chain-dashboard?panelId=76" "missedsigns.png"
generate "UJyurCTWz/chain-dashboard?panelId=77" "signeddelay.png"
generate "UJyurCTWz/chain-dashboard?panelId=81" "load.png"
#generate "UJyurCTWz/chain-dashboard?panelid=85" "memory.png"

s3cmd put -M -r *.png "s3://jerrys-pool/"
echo "Done."
