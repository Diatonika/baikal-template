set dotenv-load := true
set windows-shell := ["pwsh.exe", "-NoLogo", "-Command"]

# Directories for Linter
linter-folders := "template"

do-format := "false"
format-flags := if do-format == "false" { "--diff --color" } else { "" }

nexus-read-user := env("NEXUS_READ_USER")
nexus-read-pass := env("NEXUS_READ_USER")

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
black: init-dev
    poetry run black {{ linter-folders }} --config pyproject.toml {{ format-flags }}

[group("lint")]
flake: init-dev
    poetry run flake8 {{ linter-folders }} --config .flake8

[group("lint")]
isort: init-dev
    poetry run isort {{ linter-folders }} --settings pyproject.toml {{ format-flags }}

[group("lint")]
mypy: init-dev
    poetry run mypy {{ linter-folders }} --config-file pyproject.toml

[group("lint")]
format:
    just --set do-format true isort black

[group("lint")]
lint: mypy flake isort black
