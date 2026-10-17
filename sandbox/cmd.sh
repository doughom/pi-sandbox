#!/bin/bash

activate="$UV_PROJECT_ENVIRONMENT/bin/activate"
if [ -f "$activate" ]; then
    source "$activate"
fi

pi "$@"
