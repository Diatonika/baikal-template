set dotenv-load := true
set windows-shell := ["pwsh.exe", "-NoLogo", "-Command"]

# Directories for Linter & Formatter
source-dirs := "src"

nexus-read-user := env("NEXUS_READ_USER")
nexus-read-pass := env("NEXUS_READ_PASS")

default:
    @just --list

[group("setup")]
init *sync-options: && (sync sync-options)
    poetry config virtualenvs.in-project true --local
    poetry config http-basic.baikal-pypi {{ nexus-read-user }} {{ nexus-read-pass }} --local

[group("setup")]
init-dev: init

[group("setup")]
init-release: (init "--only" "main")

[group("setup")]
sync *options:
    poetry sync {{ options }}

[group("setup")]
sync-dev: sync

[group("setup")]
sync-release: (sync "--only" "main")

[group("setup")]
update *options:
    poetry update {{ options }}

[group("setup")]
build *options:
    poetry build {{ options }}

[group("lint")]
lint-check: init-dev
    poetry run ruff check {{ source-dirs }} --config pyproject.toml
    poetry run mypy {{ source-dirs }} --config-file pyproject.toml

[group("lint")]
lint-fix: init-dev
    poetry run ruff check --fix-only {{ source-dirs }}

[group("format")]
format-check: init-dev
    poetry run ruff format --diff {{ source-dirs }}

[group("format")]
format-fix: init-dev
    poetry run ruff format {{ source-dirs }}
