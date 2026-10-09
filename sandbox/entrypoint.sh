#!/bin/bash
set -eu

# Update model list
modelsConfig="$HOME/.pi/agent/models.json"
baseUrl=$(jq --raw-output .providers.lmstudio.baseUrl "$modelsConfig")
models=$(curl --silent "$baseUrl/models" | jq '.data[] | {id: .id}' | jq --slurp .)
tempfile=$(mktemp)
jq --argjson models "$models" '.providers.lmstudio.models = $models' "$modelsConfig" > "$tempfile"
mv "$tempfile" "$modelsConfig"

# Update context window from LM Studio API
# Use configured length if model is loaded, else use max length
tempfile=$(mktemp)
jq --argjson samples "$(curl --silent "${baseUrl/v1/api/v1/models}")" '
    .providers.lmstudio.models |= map(
        .contextWindow = (
            .id as $id |
            ($samples.models[] | select(.key == $id)) as $m |
            if ($m.loaded_instances | length > 0) then
                $m.loaded_instances[0].config.context_length
            else
                $m.max_context_length
            end
        )
    )
' "$modelsConfig" > "$tempfile"
mv "$tempfile" "$modelsConfig"

pi
