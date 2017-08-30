#!/bin/bash
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
helm del --purge catalog
