# homebrew-tap

Homebrew tap for trevin-lee's tools.

| | |
|---|---|
| [prusactl](https://github.com/trevin-lee/prusactl) | Run a Prusa 3D printer from the terminal or an AI agent (CLI + MCP server) |
| [ide-design](https://github.com/trevin-lee/ide-design) | Parametric graphic design: decks, docs and brand systems as token-only React, checked like code (command: `ided`) |
| [claude-router](https://github.com/trevin-lee/claude-router) | Keep several Claude accounts signed in at once, switch between them, and see each one's usage |

```sh
brew install trevin-lee/tap/prusactl
brew install trevin-lee/tap/ide-design
brew install trevin-lee/tap/claude-router
```

Installing by the full name trusts that one formula or cask (Homebrew's tap trust).
ide-design was called `ided` before 0.3.0. Trust applies to the name, so an existing install moves
over with:

```sh
brew trust --formula trevin-lee/tap/ide-design
brew update && brew migrate ided && brew upgrade ide-design
```

All are published here by their own release workflows; don't edit them by hand.
