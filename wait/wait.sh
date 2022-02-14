#!/bin/bash
#
# Usage:
# e.g.
# sh wait.sh tcp localhost 8080
# sh wait.sh http www.google.com 80
#
set -e
trap exit INT

COLOR_RED='\033[0;31m'
COLOR_GREEN='\033[0;32m'
COLOR_YELLOW='\033[0;33m'

function echo_with_color {
    printf "$1$2\033[0m\n"
}

function err_exit {
    echo_with_color "${COLOR_RED}" "$1"
    exit 1
}

function success_exit {
    echo_with_color ${COLOR_GREEN} "wait passed"
    exit 0;
}

TIMEOUT=120 # seconds

PROBE_HTTP="http"
PROBE_TCP="tcp"

# protocol, domain_name, port
# httpGet, path, port, httpHeaders,
# tcpSocket, path, port
PROBE_TYPE=$1
SERVICE_NAME=$2
SERVICE_PORT=$3
if [[ $# -ge 4 ]]; then
  TIMEOUT=$4
fi

function wait_tcp() {
  for i in `seq $TIMEOUT`; do
    if nc -vtz "$SERVICE_NAME" "$SERVICE_PORT" > /dev/null 2>&1; then
       success_exit
    fi
    sleep 1
  done

  err_exit "launch failed, depended service is not ready..."
}

function wait_http() {
  for i in `seq $TIMEOUT` ; do
    if [[ `curl -m 1 -I -o /devl/null -s -w %{http_code} $SERVICE_NAME:$SERVICE_PORT` == 200 ]]; then
       success_exit
    fi
    sleep 1
  done

  err_exit "launch failed, depended service is not ready..."
}

function main() {
  echo "Wait for dependencies ready..."
  echo "probe_type: $PROBE_TYPE, service_name: $SERVICE_NAME, service_port: $SERVICE_PORT, timeout: $TIMEOUT"
  case $PROBE_TYPE in
    $PROBE_HTTP)
      wait_http
      ;;
    "$PROBE_TCP")
      wait_tcp
      ;;
  esac
}

main