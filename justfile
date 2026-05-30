@_default:
    just --list

# Build the project
build: setup
    npm run build

# Watch for changes and rebuild things as needed
dev: setup
    npm run dev

alias fmt := format
# Format the entire codebase
format:
    treefmt

# Install npm dependencies and the like
setup:
    npm install

# Update all dependencies
update:
    npins update
    npm update --package-lock-only
