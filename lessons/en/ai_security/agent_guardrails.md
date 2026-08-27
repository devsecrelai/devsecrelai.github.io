%{
  version: "0.1.0",
  title: "Agent Guardrails",
  excerpt: "Apply least privilege, validation, and oversight to every action an AI agent can take."
}
---

## Scope tools narrowly

Give an agent only the tools and permissions required for its task. Read-only access is safer than write access, and a dedicated service identity is safer than a shared administrator credential.

{% include toc.html %}

## Validate every boundary

Validate inputs before they reach a tool and validate outputs before they affect a user or system. Prefer structured requests with allowlisted operations and parameters over free-form commands.

## Keep humans in the loop

Require approval for irreversible, external, or high-impact actions. Log the request, context, chosen tool, result, and approver to make review and incident response possible.
