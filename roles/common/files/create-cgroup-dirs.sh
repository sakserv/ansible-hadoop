#!/bin/bash

mkdir -p /sys/fs/cgroup/cpu/hadoop-yarn
chown -R yarn /sys/fs/cgroup/cpu/hadoop-yarn
mkdir -p /sys/fs/cgroup/memory/hadoop-yarn
chown -R yarn /sys/fs/cgroup/memory/hadoop-yarn
mkdir -p /sys/fs/cgroup/blkio/hadoop-yarn
chown -R yarn /sys/fs/cgroup/blkio/hadoop-yarn
mkdir -p /sys/fs/cgroup/net_cls/hadoop-yarn
chown -R yarn /sys/fs/cgroup/net_cls/hadoop-yarn
