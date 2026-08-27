%{
  version: "0.1.0",
  title: "Threat Modeling",
  excerpt: "Turn assumptions about a system into a concrete, reviewable security plan."
}
---

## Start with the system

A useful threat model is a shared picture of what the system does, which data it handles, and where trust changes. Sketch the user, service, model, tool, data store, and third-party boundaries before naming threats.

{% include toc.html %}

## Ask the right questions

For each boundary, ask who can send data, what they control, what the service trusts, and how abuse would be detected. Record the risk, its owner, and the smallest practical mitigation.

## Make it a team habit

Run a short threat-model review when an architecture changes, a new integration is introduced, or an AI capability gains a tool or data source. The output should influence delivery work, not become a document that no one revisits.
