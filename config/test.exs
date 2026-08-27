import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :dev_sec_rel_ai, DevSecRelAIWeb.Endpoint, server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :dev_sec_rel_ai,
  lesson_dir: "test/support/content/lessons",
  blog_dir: "test/support/content/posts/**/*.md",
  conference_dir: "test/support/content/conferences/**/*.md"

config :dev_sec_rel_ai,
  lessons: [
    basics: [
      :basics,
      :collections,
      :functions,
      :enum
    ],
    intermediate: [
      :mix_tasks,
      :erlang
    ]
  ]

config :dev_sec_rel_ai,
  future_lessons: [
    :mix_tasks,
    :functions
  ]
