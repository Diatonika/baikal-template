# Baikal Template Repository #

## GitHub Repository Setup ##

Create the following repository GitHub Actions variables:

1. `PYTHON_VERSION`: Python version to set up in `lint` workflow environment.

## Project Setup ##

### Tools ###

1. Install `Python 3.X`.
2. Install [Poetry](https://python-poetry.org/docs/).
3. Install [Just](https://just.systems/man/en/packages.html).

### Environment File ###

1. Copy `.env.example` file as `.env`.
2. Fill in private PyPI credentials.

### Project Initialization ###

Populate `linter-folders` variable inside `justfile` with directories for linter checks and run:

```bash
just init-dev
```

### PyCharm Plugins ###

1. [Just Plugin](https://plugins.jetbrains.com/plugin/18658-just): IDE support for `justfile`.
2. [MyPy Plugin](https://plugins.jetbrains.com/plugin/11086-mypy): IDE support for `MyPy` inspections.

### PyCharm Setup ###

1. `CTRL + ALT + S` → `Mypy` → `Path To Config File`: `pyproject.toml`.
2. `CTRL + ALT + S` → `Tools` → `Black` → `On Code Reformat`: `true`.

### Semantic Release ###

1. Your commits messages must
   follow [Conventional Commits Specification](https://www.conventionalcommits.org/en/v1.0.0/).
2. Package release is automated
   by [Python Semantic Release GitHub Action](https://github.com/python-semantic-release/python-semantic-release).
3. When you are ready to release a stable version, set `pyproject.toml:major_on_zero` to `true` and run Python Semantic
   Release again. This will increment the major version to `1.0.0`.
