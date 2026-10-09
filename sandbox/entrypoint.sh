#!/bin/bash
set -eu

# Update model list
modelsConfig="$HOME/.pi/agent/models.json"
baseUrl=$(jq --raw-output .providers.lmstudio.baseUrl "$modelsConfig")
models=$(curl --silent "$baseUrl/models" | jq '.data[] | {id: .id}' | jq --slurp .)
tempfile=$(mktemp)
jq --argjson models "$models" '.providers.lmstudio.models = $models' "$modelsConfig" > "$tempfile"
mv "$tempfile" "$modelsConfig"

pi
