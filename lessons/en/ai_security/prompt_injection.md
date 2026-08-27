%{
  version: "0.1.0",
  title: "Prompt Injection",
  excerpt: "Treat untrusted model input as data, not instructions with authority."
}
---

## Separate data from authority

Text from users, documents, websites, and tools may attempt to change an agent's behavior. Give it no authority by default, and keep system policy, tool permissions, and user data in separate channels.

{% include toc.html %}

## Limit downstream impact

Constrain tool access, validate structured outputs, and require explicit user confirmation for consequential actions. An injected instruction should not be able to send mail, reveal data, or modify systems on its own.

## Test adversarially

Maintain an evaluation set of prompt-injection attempts that exercise retrieval, multi-step workflows, and tool use. Run it whenever models, prompts, tools, or retrieval sources change.
