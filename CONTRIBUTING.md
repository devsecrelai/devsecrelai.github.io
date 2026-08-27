# Contributing to DevSecRelAI

Thanks for helping improve DevSecRelAI. Keep each pull request focused on one lesson, translation, editorial item, or tightly related update.

1. Put the source file in the appropriate directory described in [CONTENT.md](CONTENT.md).
2. Use the required front matter and write a clear, searchable title and excerpt.
3. For a translation, preserve the English lesson's section, slug, and version. Run `make translation-report` to identify missing or stale translations.
4. For an existing lesson, update its version according to the change: patch for corrections, minor for additions, major for incompatible guidance.
5. Run `make setup` and `mix test` before opening a pull request.

Do not add generated static files, build output, or dependencies as part of a content-only change. If a change needs a new curriculum section or a new metadata field, include the corresponding application and documentation updates in the same pull request.
