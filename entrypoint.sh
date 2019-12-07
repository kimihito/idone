#!/bin/bash

set -e

sudo chown -R idone:idone .

exec "$@"