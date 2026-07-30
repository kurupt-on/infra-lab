#!/usr/bin/env bash

. ../.env.host

virsh stop "$VM"
