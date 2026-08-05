#!/usr/bin/env bash

. "$( dirname $0 )/../.env.host"

virsh stop "$VM"
