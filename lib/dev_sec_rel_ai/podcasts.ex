defmodule DevSecRelAI.Podcasts do
  @moduledoc false

  use NimblePublisher,
    build: DevSecRelAI.Content.Podcast,
    from: Application.compile_env!(:dev_sec_rel_ai, :podcast_dir),
    as: :podcasts,
    highlighters: [:makeup_elixir, :makeup_erlang]

  def list, do: @podcasts
end
