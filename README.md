# DevSecRelAI

[![Continuous Integration](https://github.com/DevSecRelAI/devsec-rel-ai/actions/workflows/ci.yml/badge.svg)](https://github.com/DevSecRelAI/devsec-rel-ai/actions/workflows/ci.yml) [![Deploy](https://github.com/DevSecRelAI/devsec-rel-ai/actions/workflows/deploy.yml/badge.svg)](https://github.com/DevSecRelAI/devsec-rel-ai/actions/workflows/deploy.yml)

DevSecRelAI is an open learning platform for the practices where developer experience, security, reliability, and AI meet. It is powered by Elixir and Phoenix.

It uses [NimblePublisher](https://github.com/dashbitco/nimble_publisher) to publish versioned Markdown lessons and articles. Starter content is included in this repository, so a clone is self-contained.

## Content

The curriculum and editorial content live alongside the application code in this repository: `lessons/`, `posts/`, `podcasts/`, `conferences/`, and `images/`. See [CONTENT.md](CONTENT.md) for the supported formats and [CONTRIBUTING.md](CONTRIBUTING.md) for the contribution workflow.

### Translation report

Compare each translated lesson against its English source with:

```shell
$ make translation-report
```

Pass filters through `ARGS`, for example `make translation-report ARGS="--lang es,ja --severity major,missing"`.

## GitHub Pages

DevSecRelAI can export its public content to a static GitHub Pages artifact. Build it locally with:

```shell
$ make github-pages
```

The generated site is placed in `github-pages/`. The included GitHub Actions workflow deploys this directory on pushes to `main` after GitHub Pages has been configured to use **GitHub Actions** as its publishing source.

The export targets the organization URL `https://devsecrelai.github.io/`, so it must be deployed from the `devsecrelai/devsecrelai.github.io` repository to be served at that root URL. A project repository would instead be served below a path such as `/devsec-rel-ai/` and needs a separate base-path configuration.

GitHub Pages serves static files only. Lessons, posts, translations, and the default events listing are included; Phoenix/LiveView features such as interactive conference filtering require the server-hosted deployment.

## Development

To get up and running all we need is a single command:

```shell
$ make setup
```

This installs dependencies, compiles the project, and builds the front-end assets.

Then start the phoenix server with:

```shell
$ mix phx.server
```

Before deploying, set `PHX_HOST`, `FLY_APP_NAME`, and the target repository URLs in the deployment files for your organization.
