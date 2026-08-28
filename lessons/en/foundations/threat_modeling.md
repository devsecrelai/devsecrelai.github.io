%{
  version: "0.3.0",
  title: "Threat Modeling 101",
  excerpt: "Turn assumptions about a system into a concrete, reviewable security plan."
}
---

Threat modeling turns an architecture diagram into a short, actionable security plan. Start small: model one user journey, identify the assets and trust boundaries, then decide which risks deserve a concrete response.

{% include toc.html %}

## Start with the system

Before naming threats, make the system understandable to everyone in the room. Sketch the user, service, model, tool, data store, and third-party boundaries. Draw an arrow for every meaningful data flow, especially where untrusted input becomes trusted data or gains access to a sensitive capability.

### A minimal model

Include these building blocks in the first draft:

- **Actors** — people, services, agents, or external systems that initiate actions.
- **Processes** — applications, APIs, workers, models, or tools that transform data.
- **Data stores** — databases, object storage, vector stores, logs, and queues.
- **Trust boundaries** — points where identity, ownership, permission, or validation changes.
- **Assets** — data, credentials, capabilities, or business outcomes worth protecting.

> Keep the first diagram small enough to discuss in ten minutes. You can add detail after the team agrees on the main flow.

## Tool 1 OWASP Threat Dragon

[OWASP Threat Dragon](https://owasp.org/www-project-threat-dragon/docs-2/introduction/) is a free, open-source tool for turning a sketch into a data-flow diagram and recording threats and mitigations against its elements. It supports frameworks such as STRIDE, LINDDUN, CIA, CIA-DIE, and PLOT4ai.

### Five minute workflow

1. Create a model for one feature or user journey.
2. Add its actors, processes, data stores, and trust boundaries.
3. Draw only data flows that the team can explain.
4. Record the threat, impact, owner, and mitigation for each relevant element.
5. Save the model with the design or code it describes so it evolves with the system.

## Ask the right questions

For each boundary, ask:

- Who can send data here, and what can they control?
- What does this component trust without validating?
- Which asset could be exposed, changed, or made unavailable?
- What signal would tell us that abuse is happening?
- What is the smallest practical mitigation, and who owns it?

Write down the risk even when you postpone the mitigation. A visible, owned decision is safer than an undocumented assumption.

## Threat Modeling for AI ML Systems

An AI or machine learning system uses models and data to make predictions, classifications, recommendations, or decisions. It may also retrieve documents, call tools, or trigger actions. These capabilities make the trust boundaries wider: the model, its inputs, its retrieved context, and its tools all need to be considered.

Threat modeling helps a team decide where an AI system may be manipulated, leak sensitive information, make an unsafe decision, or take an action beyond its intended authority. Treat untrusted prompts, documents, model outputs, and tool responses as data until they are explicitly validated.

### The AI ML lifecycle

Model the lifecycle, not only the deployed model:

1. **Data collection** — identify data sources, consent, ownership, and poisoning risks.
2. **Preparation and training** — protect datasets, training jobs, secrets, and model artifacts.
3. **Validation and release** — test for unsafe behavior, bias, data leakage, and abuse cases before deployment.
4. **Inference and tool use** — constrain prompts, retrieval, model outputs, and permissions granted to tools.
5. **Monitoring and maintenance** — log meaningful events, detect drift or misuse, and make rollback and retraining decisions reviewable.

### A practical starter template

Use this short template in a design review or in Threat Dragon:

```text
System or feature: <one user journey>
Assets to protect: <data, credentials, money, availability, trust>
Trust boundaries: <where validation, identity, or permission changes>
Threat: <what could go wrong>
Impact: <who or what is harmed>
Mitigation: <smallest effective control>
Owner and review date: <person or team, date>
```

## Make it a team habit

Run a short threat-model review when an architecture changes, a new integration is introduced, or an AI capability gains a tool or data source. The output should influence delivery work, not become a document that no one revisits.
