import Config

config :dev_sec_rel_ai,
  future_lessons: []

config :dev_sec_rel_ai,
  lessons: [
    foundations: [
      :threat_modeling,
      :secure_by_design
    ],
    secure_delivery: [
      :software_supply_chain,
      :secrets_management
    ],
    ai_security: [
      :prompt_injection,
      :agent_guardrails
    ],
    resilience: [
      :detection_and_response,
      :incident_communication
    ]
  ]
