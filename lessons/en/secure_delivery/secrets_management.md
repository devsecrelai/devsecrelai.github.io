%{
  version: "0.1.0",
  title: "Secrets Management",
  excerpt: "Keep credentials out of source code and make access short-lived, scoped, and auditable."
}
---

## Treat secrets as production data

Passwords, API keys, signing keys, and tokens require a managed lifecycle. Never place them in source, documentation, images, or client-side applications.

{% include toc.html %}

## Prefer identity over static keys

Use workload identity and short-lived credentials when possible. Limit each secret to one purpose and rotate it on a schedule and after suspected exposure.

## Make accidental exposure recoverable

Scan commits and build logs, revoke exposed values quickly, and document the owner and rotation process. Detection is valuable only when it is paired with a reliable response path.
