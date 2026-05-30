
@_default:
    just --list

alias fmt := format
# Format the entire codebase
format:
    treefmt
