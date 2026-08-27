# DevSecRelAI content

DevSecRelAI keeps all publishable source material in this repository. The application compiles Markdown from these directories at build time; no separate content repository or runtime clone is required.

```
lessons/
  en/
    foundations/
    secure_delivery/
    ai_security/
    resilience/
  <locale>/
posts/
podcasts/
conferences/
images/
```

## Lessons

Store a lesson at `lessons/<locale>/<section>/<slug>.md`. Sections describe a stable curriculum area. Use a lowercase, underscore-separated slug and keep translated lessons in the same section and slug as the English source.

Each lesson begins with Elixir-map front matter followed by `---`:

```md
%{
  version: "0.1.0",
  title: "Threat Modeling",
  excerpt: "Turn assumptions about a system into a concrete, reviewable security plan."
}
---
```

Increase the patch version for corrections, the minor version for meaningful additions, and the major version when the lesson changes in a way that invalidates prior guidance. Keep excerpts short enough to work in lesson cards and search results.

Translations use the same section, slug, and version as their English source. Run `make translation-report` to find missing or outdated translations; filter the report with `ARGS="--lang es,ja --severity major,missing"`.

## Posts

Store posts as `posts/YYYY-MM-DD-slug.md`. Their front matter must include `author`, `author_link`, `tags`, `date`, `title`, and `excerpt`:

```md
%{
  author: "DevSecRelAI Community",
  author_link: "https://github.com/DevSecRelAI",
  tags: ["security", "reliability"],
  date: ~D[2026-08-28],
  title: "A practical delivery habit",
  excerpt: "A concise summary for the post index."
}
---
```

## Podcasts and conferences

Add one Markdown file per item directly inside `podcasts/` or `conferences/`.

Podcast metadata requires `about`, `active`, `logo`, `name`, and `website`; `language` is optional. Set `logo` to a path below `images/`, without the `images/` prefix—for example, `podcasts/show-logo.png`.

Conference metadata requires `name`, `link`, and `date`; `series`, `location`, and `country` are optional. Dates use `~D[YYYY-MM-DD]`.

## Images

Place content-owned images under `images/`, for example `images/podcasts/show-logo.png`. The local setup and production build copy these images into the app's static assets, where that file is served at `/images/podcasts/show-logo.png`.
