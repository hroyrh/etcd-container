#!/bin/sh

export ETCD_NAME="$HOSTNAME"
export ETCD_DATA_DIR="/var/lib/etcd/$HOSTNAME.etcd"
export ETCD_ADVERTISE_CLIENT_URLS="http://0.0.0.0:2379,http://0.0.0.0:4001"
export ETCD_LISTEN_CLIENT_URLS="http://0.0.0.0:2379,http://0.0.0.0:4001"
export ETCD_INITIAL_ADVERTISE_PEER_URLS="http://$HOSTNAME:2380,http://$HOSTNAME:7001"
export ETCD_LISTEN_PEER_URLS="http://$HOSTNAME:2380,http://$HOSTNAME:7001"
export ETCD_INTIAL_CLUSTER="$HOSTNAME=http://$HOSTNAME:2380,http://$HOSTNAME:7001"

# Execute the commands passed to this script
exec "$@"
