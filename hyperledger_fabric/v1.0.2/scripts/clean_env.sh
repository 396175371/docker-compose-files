#!/usr/bin/env bash

# This script will remove all containers and hyperledger related images

# Detecting whether can import the header file to render colorful cli output
# Need add choice option
if [ -f ./header.sh ]; then
 source ./header.sh
elif [ -f scripts/header.sh ]; then
 source scripts/header.sh
else
 echo_r() {
	 echo "$@"
 }
 echo_g() {
	 echo "$@"
 }
 echo_b() {
	 echo "$@"
 }
fi

echo_b "Clean up all containers..."
docker rm -f `docker ps -qa`

echo_b "Clean up all chaincode images..."
docker rmi -f $(docker images |grep 'dev-peer'|awk '{print $3}')

echo_b "Clean up all hyperledger related images..."
docker rmi -f $(docker images |grep 'hyperledger'|awk '{print $3}')

echo_b "Clean up dangling images..."
docker rmi $(docker images -q -f dangling=true)

echo_g "Env cleanup done!"