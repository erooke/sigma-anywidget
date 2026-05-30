
@_default:
    just --list

alias fmt := format
# Format the entire codebase
format:
    treefmt

# Update all dependencies
update:
    npins update
