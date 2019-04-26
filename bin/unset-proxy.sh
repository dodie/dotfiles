#! /bin/bash

# Usage: source unset-proxy.sh

while read var; do unset $var; done < <(env | grep proxy | sed -e 's/=.*//g')
