#!/usr/bin/env bash
set -euo pipefail
cd -- "$(dirname -- "$0")"

docker build -q -t project10-dns:lab .
docker build -q -t project10-web:lab web

network=$(docker network create --internal --subnet 172.30.10.0/24 project10-lab)
dns=""
web=""
cleanup() {
  if [ -n "$web" ]; then docker rm -f "$web" >/dev/null; fi
  if [ -n "$dns" ]; then docker rm -f "$dns" >/dev/null; fi
  docker network rm "$network" >/dev/null
}
trap cleanup EXIT

dns=$(docker run -d --network "$network" --ip 172.30.10.10 project10-dns:lab)
web=$(docker run -d --network "$network" --ip 172.30.10.20 project10-web:lab)

docker run --rm --network "$network" \
  --entrypoint sh project10-dns:lab -ec '
  sleep 1
  echo "Project 10: actual DNS and HTTP test output"
  echo
  echo "$ nslookup -type=A -port=1053 app.training.test 172.30.10.10"
  lookup=$(nslookup -type=A -port=1053 app.training.test 172.30.10.10)
  printf "%s\n" "$lookup"
  printf "%s\n" "$lookup" | grep -q "172.30.10.20"
  address=$(dig +short -p 1053 @172.30.10.10 app.training.test A)
  if [ "$address" != "172.30.10.20" ]; then
    echo "ERROR: unexpected DNS A record: $address" >&2
    exit 1
  fi
  echo
  echo "$ curl --resolve app.training.test:8000:$address http://app.training.test:8000/"
  page=$(curl --noproxy "*" --resolve "app.training.test:8000:$address" \
    --retry 5 --retry-connrefused --retry-delay 1 --connect-timeout 5 --max-time 10 \
    --fail --silent --show-error http://app.training.test:8000/)
  printf "%s\n" "$page"
  printf "%s\n" "$page" | grep -q "Web app reached using app.training.test."
  echo
  echo "PASS: DNS A record verified; HTTP hostname access succeeds using the DNS-returned address."
'
