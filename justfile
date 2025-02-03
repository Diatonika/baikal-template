set dotenv-load := true
set windows-shell := ["pwsh.exe", "-NoLogo", "-Command"]

do-format := "false"
format-flags := if do-format == "false" { "--diff --color" } else { "" }

default:
    @just --list

[group("setup")]
init nexus-read-user=env("NEXUS_READ_USER") nexus-read-pass=env("NEXUS_READ_PASS"): && sync
    poetry config virtualenvs.in-project true --local
    poetry config http-basic.baikal-pypi  {{ nexus-read-user }} {{ nexus-read-pass }} --local

[group("setup")]
sync:
    poetry sync

[group("setup")]
update:
    poetry update

[group("setup")]
build: sync
    poetry build

[group("lint")]
black:
    poetry run black template --config pyproject.toml {{ format-flags }}

[group("lint")]
flake:
    poetry run flake8 template --config .flake8

[group("lint")]
isort:
    poetry run isort template --settings pyproject.toml {{ format-flags }}

[group("lint")]
mypy:
    poetry run mypy -p template --config-file pyproject.toml

[group("lint")]
format:
    just --set do-format true isort black

[group("lint")]
lint: mypy flake isort black
