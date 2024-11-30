#!/usr/bin/env bash

set -euo pipefail

cat << EOF > /etc/hosts
127.0.0.1			localhost

192.168.56.201  	server1
192.168.56.202  	server2
192.168.56.203  	server3
192.168.56.204  	server4
EOF

cat /etc/hosts
