import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

export default function (pi: ExtensionAPI) {
  pi.on("session_start", async (event, ctx) => {
    const response = await fetch("http://host.docker.internal:1234/api/v1/models");
    if (response.ok) {
      const data = await response.json();
      const models = []

      for (const model of data.models) {
        if (model.type == "llm") {

          var contextLength = model.max_context_length;
          if (model.loaded_instances.length > 0) {
            contextLength = model.loaded_instances[0].config.context_length;
          }

          models.push({
            id: model.key,
            name: model.display_name,
            reasoning: true,
            contextWindow: contextLength,
            maxTokens: contextLength / 2,
            input: "text",
            cost: 1
          });
        }
      }

      pi.registerProvider("lmstudio", {
        api: "openai-completions",
        apiKey: "lmstudio",
        baseUrl: "http://host.docker.internal:1234/v1",
        models: models
      });

      ctx.ui.notify(`Registered ${models.length} model(s)`);
    }
  });
}
