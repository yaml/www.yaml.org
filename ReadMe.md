# www.yaml.org

Source repository for [yaml.org](https://yaml.org), the official website for
the YAML data language.

## Overview

This is a MkDocs Material-based website with dynamic content generation using
YAMLScript.

The site includes:

- YAML language documentation and specifications
- Libraries directory (generated from YAML data)
- Tools directory (generated from YAML data)
- Community resources

## Quick Start

### Prerequisites

- Python 3.7+
- YAMLScript (`ys` command)
- Git

### Setup and Development

```bash
# First-time setup
make deps              # Install Python dependencies (creates venv)

# Local development
make serve             # Start dev server at http://localhost:8000
                      # Auto-watches .ys and .yaml files for changes

# Build production site
make build            # Generate static site to site/

# Deploy to GitHub Pages
make publish          # Deploy to https://yaml.org
```

## Project Structure

### Source Files
```
src/libraries.yaml     # YAML libraries data
src/libraries.ys       # YAMLScript generator for libraries page
src/tools.yaml         # YAML tools data
src/tools.ys           # YAMLScript generator for tools page
```

### Documentation Files
```
docs/                  # Generated markdown and static content
docs/libraries.md      # Generated from src/libraries.ys (gitignored)
docs/tools.md          # Generated from src/tools.ys (gitignored)
docs/about.md          # Static markdown
docs/index.md          # Homepage (static)
```

### Configuration
```
mkdocs.yaml            # MkDocs configuration
Makefile               # Build system
requirements.txt       # Python dependencies
theme/                 # Custom theme overrides
docs/css/extra.css     # Custom styles
```

### Other Directories
```
spec/                  # YAML specifications (published but not maintained here)
type/                  # YAML type documentation
template/              # HTML templates for spec generation
site/                  # Generated production site (gitignored)
```

## Build System

The site uses a sophisticated build system:

1. **YAMLScript Generation**: `.ys` files read `.yaml` data and generate
   markdown
2. **File Watcher**: Automatically regenerates pages when source files change
3. **MkDocs Build**: Processes markdown into static HTML
4. **Publishing**: Deploys to GitHub Pages via gh-pages branch

## Contributing

We welcome contributions! See [Contributing.md](Contributing.md) for details on:

- Adding YAML libraries
- Adding YAML tools
- Editing content
- Understanding the badge system

## Key Commands

```bash
make deps          # Install dependencies
make serve         # Local dev server with auto-reload
make build         # Build production site
make publish       # Deploy to GitHub Pages
make pages         # Manually regenerate markdown from YAMLScript
make clean         # Remove generated files
make lint          # Run typos linter
```

## Links

- **Website**: https://yaml.org
- **Repository**: https://github.com/yaml/www.yaml.org
- **Issues**: https://github.com/yaml/www.yaml.org/issues
- **Chat**: https://matrix.to/#/#chat:yaml.io
- **IRC**: #yaml on irc.libera.chat

## License

The upkeep of https://yaml.org is a community project.
