#!/bin/bash
rocm-smi -t --json | jq -r '.card0.[]' | sort -n | tail -1 | awk '{printf "%d\n", $1}'
