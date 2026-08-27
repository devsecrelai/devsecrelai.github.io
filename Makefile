.PHONY: $(MAKECMDGOALS) content-assets github-pages translation-report

setup: content-assets
	mix do setup, compile, assets.deploy

content-assets:
	mkdir -p assets/static/images
	cp -R images/. assets/static/images/

translation-report:
	elixir bin/version_report.exs $(ARGS)

github-pages: content-assets
	mix do setup, compile, assets.deploy
	mix dev_sec_rel_ai.export.github_pages --output github-pages

build:
	docker build .
