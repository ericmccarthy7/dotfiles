#!/bin/bash
rocm-smi -u --json | jq -r '.card0.[]'
