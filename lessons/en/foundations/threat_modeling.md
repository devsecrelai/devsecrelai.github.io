%{
  version: "0.2.0",
  title: "Threat Modeling 101",
  excerpt: "Turn assumptions about a system into a concrete, reviewable security plan."
}
---

## Start with the system

A useful threat model is a shared picture of what the system does, which data it handles, and where trust changes. Sketch the user, service, model, tool, data store, and third-party boundaries before naming threats.

{% include toc.html %}

## Tool 1: OWASP Threat Dragon

[OWASP Threat Dragon](https://owasp.org/www-project-threat-dragon/docs-2/introduction/) is a free, open-source tool for turning that sketch into a data-flow diagram, then recording threats and mitigations against its elements. It supports frameworks such as STRIDE, LINDDUN, CIA, CIA-DIE, and PLOT4ai.

Start with one small workflow: add the actors, processes, data stores, and trust boundaries; draw only the data flows you can explain; then record the threat, impact, owner, and mitigation for each relevant element. Save the model with the design or code it describes so the review can evolve with the system.

## Ask the right questions

For each boundary, ask who can send data, what they control, what the service trusts, and how abuse would be detected. Record the risk, its owner, and the smallest practical mitigation.

## Make it a team habit

Run a short threat-model review when an architecture changes, a new integration is introduced, or an AI capability gains a tool or data source. The output should influence delivery work, not become a document that no one revisits.
