#!/bin/bash
find $(cd $(dirname $0); pwd) -name "*.lastUpdated" -type f -print -exec rm -rf {} \;
find $(cd $(dirname $0); pwd) -name "_remote.repositories" -type f -print -exec rm -rf {} \;