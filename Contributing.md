Contributing to www.yaml.org
============================

The upkeep of https://www.yaml.org is a community project.
You can easily contribute!
Just fork, make changes and send us a Pull Request.

## Changing the YAML Specfication files

The YAML specs are published on yaml.org from this repository, but the source
files for modifying them are located here: <https://github.com/yaml/yaml-spec>.
Please submit spec related pull requests there.

## Adding a YAML Library

Thanks for adding a library we don't yet know about!
Please help making the list of libraries more useful.

To add a library, edit the `src/libraries.yaml` file and add an entry under the
appropriate language section:

```yaml
language-name:
- name: Library Name
  desc: Brief description including YAML version support
  site: https://library.homepage.com
  icon: simple-python  # or material-icon-name
  yts: true           # Optional: uses yaml-test-suite
  tycs: true          # Optional: supported by The YAML Company
  play: playground-id # Optional: available in YAML Playground
```

**Badge System:**
- `yts: true` - Library uses the official
  [yaml-test-suite](https://github.com/yaml/yaml-test-suite)
- `tycs: true` - Library is supported by [The YAML Company](https://yaml.com)
- `play: playground-id` - Library is available in the
  [YAML Playground](https://play.yaml.io)

**Icon Format:**
- Material Design icons: `material-icon-name` (e.g., `material-code-braces`)
- Simple icons: `simple-brand` (e.g., `simple-python`, `simple-javascript`)
- Browse icons at [materialdesignicons.com](https://materialdesignicons.com/) and [simpleicons.org](https://simpleicons.org/)

Please note that it makes it easier to review it the more information is
provided.
The linked library homepage should ideally have the following information:

* The implemented YAML version(s) (1.0, 1.1, 1.2)
* How complete the YAML version is implemented; what it doesn't do
* Which schemas are implemented.
  See [this list of schemas](
  https://perlpunk.github.io/yaml-test-schema/schemas.html).
  For YAML 1.2 this should at least be the Core Schema.
  If it doesn't do resolving (booleans, integers etc.) at all, this information
  should ideally also be on the homepage.
* Tests/CI: Does the lib use the official
  [yaml-test-suite](https://github.com/yaml/yaml-test-suite)?
  Or does it have its own test cases? Are they linked from the Homepage?

The list of YAML libraries is growing, and they are all very different, so
it's important that people can find essential information about the library
at one glance.

If you are the author or know the library well, please consider adding it to
the docker [yaml-runtimes](https://github.com/yaml/yaml-runtimes), which is the
base for the [yaml-test-matrix](https://matrix.yaml.io/).
This helps making visible how complete the library is.

## Adding a YAML Tool

To add a tool or utility, edit the `src/tools.yaml` file and add an entry under
the appropriate category:

```yaml
category-name:
- name: Tool Name
  desc: Brief description of what the tool does
  site: https://tool.homepage.com
  icon: material-console  # or simple-icon-name
  type: cli              # Required: "cli" or "web"
  tycs: true             # Optional: supported by The YAML Company
```

**Badge System:**
- `type: cli` - Command-line interface tool (required for all tools)
- `type: web` - Web-based tool (required for all tools)
- `tycs: true` - Tool is supported by [The YAML Company](https://yaml.com)

**Categories:**
- Utilities - General YAML processing tools
- Linters & Validators - Code quality and syntax checking
- Schema & Validation - Data validation tools
- Editors & IDE Tools - Development environment integrations
- Related Technologies - Adjacent technologies and formats

## About, Contact

This git repo is hosted at: <https://github.com/yaml/www.yaml.org>.

Please file issues and pull requests here:
<https://github.com/yaml/www.yaml.org/issues>.

If you want to chat about YAML or this site, drop by
<https://matrix.to/#/#chat:yaml.io>.
If IRC is more your style, join #yaml on the irc.libera.chat network.

## Viewing the site locally

The site uses MkDocs with live reload.
To view changes locally:

```bash
# First-time setup
make deps              # Install Python dependencies

# Start local dev server
make serve             # Runs at http://localhost:8000

# The dev server automatically:
# - Watches for file changes (src/*.yaml, src/*.ys)
# - Regenerates markdown pages
# - Reloads your browser
```

When you edit `src/libraries.yaml` or `src/tools.yaml`, the corresponding
markdown pages are automatically regenerated and your browser refreshes.

## Understanding the Build System

The site uses a multi-stage build process:

```
YAML Data → YAMLScript Generator → Markdown → MkDocs → HTML
```

**File Structure:**
- `src/libraries.yaml` - Library data
- `src/libraries.ys` - YAMLScript generator script
- `docs/libraries.md` - Generated markdown (gitignored)
- `site/libraries/` - Final HTML output (gitignored)

**How it works:**
1. **YAMLScript Generators**: `.ys` files are functional programs that read
   `.yaml` data files and generate markdown
2. **File Watcher**: Monitors `src/*.yaml` and `src/*.ys` for changes,
   automatically regenerates markdown
3. **MkDocs**: Converts markdown to HTML with Material theme and custom styling
4. **Live Reload**: Browser automatically refreshes when files change

**Build Commands:**
```bash
make pages     # Manually regenerate markdown from YAMLScript
make build     # Build complete static site to site/
make publish   # Deploy to GitHub Pages (https://yaml.org)
make clean     # Remove generated files
```

The same pattern is used for both the libraries page and tools page.
If you need to modify the page layout or structure, edit the `.ys` generator
file rather than the generated markdown.
