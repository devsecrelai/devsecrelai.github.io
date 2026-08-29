%{
  version: "0.5.0",
  title: "Threat Modeling 101",
  excerpt: "Turn assumptions about a system into a concrete, reviewable security plan."
}
---

Threat modeling turns an architecture diagram into a short, actionable security plan. Start small: model one user journey, identify the assets and trust boundaries, then decide which risks deserve a concrete response.

## Start with the system

Before naming threats, make the system understandable to everyone in the room. Sketch the user, service, model, tool, data store, and third-party boundaries. Draw an arrow for every meaningful data flow, especially where untrusted input becomes trusted data or gains access to a sensitive capability.

![A user request crosses public and protected trust boundaries before reaching an AI agent, an approved tool, and customer records.](/images/lessons/threat-modeling-system-flow.svg)

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


## Tool 2 IriusRisk

### Security content

IriusRisk provides structured security content that helps organizations identify threats, assess risks, and define appropriate security controls during the threat modeling process.

#### Risk pattern libraries

Risk Pattern Libraries are collections of predefined:

* Threats
* Weaknesses
* Countermeasures
* Security controls

These are grouped into specific risk patterns and can be automatically applied to system components during threat modeling.

#### Security classifications

Security Classifications provide a framework for categorizing assets and system components based on factors such as:

* Sensitivity
* Business importance
* Confidentiality
* Integrity
* Availability

These classifications help determine the appropriate level of security controls required for each component or asset.

#### Security frameworks and compliance

IriusRisk supports the integration of various security frameworks, standards, and regulatory requirements into the threat modeling process.

This allows organizations to align identified threats and countermeasures with security and compliance requirements.

Examples may include:

* OWASP
* NIST
* ISO 27001
* PCI DSS
* GDPR
* MITRE ATT&CK
* Other industry-specific security standards

### Objects and workflows

#### Components

Components represent the individual parts of a system architecture.

Examples include:

* Applications
* Software modules
* APIs
* Databases
* Hardware devices
* Cloud services
* Microservices
* Third-party services

Components are typically represented within the architecture diagram and are evaluated for potential threats.

#### Assets

Assets are valuable resources, information, or data that an organization aims to protect.

Examples include:

* Customer information
* Credentials
* Financial data
* Intellectual property
* Application data
* Cryptographic keys
* Business-critical information

Understanding the assets associated with a component helps determine the impact of potential threats.

#### Trust zones

Trust Zones are logical or conceptual areas within a system that share common security or trust characteristics.

Examples include:

* Public/Internet Zone
* DMZ
* Internal Network
* Production Environment
* Development Environment
* Highly Restricted Environment

Trust Zones help identify trust boundaries and situations where data or communication crosses between environments with different security levels.

### Workflows

Workflow states in IriusRisk allow administrators to control how threat modeling projects progress through different stages.

Workflows can help enforce:

* Project review processes
* Access restrictions
* Security approvals
* Compliance checks
* Threat model validation
* Risk acceptance procedures

For example, a project could progress through states such as:

**Draft → Security Review → Remediation → Approved**

Workflow states provide administrators with greater control over project access, security restrictions, governance, and compliance enforcement.

### User settings and access management

#### Users

Administrators can create and manage user accounts within IriusRisk.

User management may include:

* Creating users
* Updating user information
* Disabling users
* Assigning roles
* Managing access

#### Permissions

Permissions determine what actions a user is allowed to perform within the platform.

Roles and permissions can be assigned to control access to capabilities such as:

* Creating projects
* Editing threat models
* Reviewing threats
* Managing countermeasures
* Approving projects
* Managing platform configuration

#### Business units

Business Units allow organizations to logically segment projects, teams, and resources.

They can be used to ensure that users only have access to projects and information relevant to their:

* Department
* Business function
* Product team
* Region
* Organizational unit

This is particularly useful for large organizations managing multiple teams and threat modeling projects.

### Custom fields

Custom Fields provide flexibility to add organization-specific or domain-specific information to different objects within IriusRisk.

Custom fields can be used to capture information such as:

* Application owner
* Business criticality
* Data classification
* Environment
* Regulatory scope
* Risk owner
* Internal project identifiers

This allows organizations to customize IriusRisk according to their internal security and governance requirements.

### Rules

Rules are used to automate and refine the threat modeling process.

The rule engine evaluates information entered into a threat model, including:

* Architecture diagrams
* Components
* Data flows
* Trust zones
* Assets
* Security classifications
* Component properties

Based on this information, rules can automatically:

* Identify potential threats
* Apply relevant risk patterns
* Recommend countermeasures
* Modify risk calculations
* Enforce security requirements
* Apply compliance controls
* Trigger specific threat modeling actions

Rules help transform threat modeling from a completely manual activity into a more automated and repeatable security engineering process.

### Overall IriusRisk threat modeling flow

**Architecture Design**

→ Define Components
→ Define Assets
→ Define Trust Zones
→ Define Data Flows
→ Apply Security Classifications
→ Evaluate Rules and Risk Patterns
→ Identify Threats and Weaknesses
→ Recommend Countermeasures
→ Calculate and Review Risk
→ Remediate Security Issues
→ Security/Compliance Review
→ Approve the Threat Model


### Create an IriusRisk account

If you have not acquired IriusRisk, start with the Community Edition by creating an account.

1. Visit [IriusRisk](https://www.iriusrisk.com/) and select **Try Now**.
2. Select **Create free account** and provide the required information.
3. Open the [IriusRisk Community Edition projects page](https://community.iriusrisk.com/projects).

![IriusRisk Community Edition projects page.](/images/lessons/iriusrisk/IriusRisk.png)

Create a blank project, then add an architecture diagram and review the generated threat recommendations.

![Create a blank IriusRisk project.](/images/lessons/iriusrisk/tm-demo.png)

![Create an IriusRisk architecture diagram.](/images/lessons/iriusrisk/create-diagram.png)

![Review IriusRisk threat recommendations for improvement.](/images/lessons/iriusrisk/check-assesement.png)




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

![Five AI and machine learning lifecycle stages connect data collection, training, validation, inference, and monitoring in a feedback loop.](/images/lessons/ai-ml-lifecycle.svg)

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
