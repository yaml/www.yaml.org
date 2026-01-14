M := $(or $(MAKES_REPO_DIR),.cache/makes)
$(shell [ -d $M ] || git clone -q https://github.com/makeplus/makes $M)
include $M/init.mk
include $M/clean.mk
PYTHON-VENV := $(ROOT)/venv
include $M/python.mk
include $M/typos.mk
SHELL-DEPS += $(PYTHON-VENV)
include $M/shell.mk

PYTHON-VENV-SETUP := pip install -r requirements.txt

REPO  ?= git@github.com:yaml/www.yaml.org

PAGES := \
  docs/libraries.md \

WATCHER-PID := .watcher.pid

MAKES-CLEAN := site $(PAGES)
MAKES-REALCLEAN := $(PYTHON-VENV)
MAKES-DISTCLEAN := .cache/

DEPS := \
  $(PYTHON-VENV) \
  $(PAGES) \


default::
# Build main site (production)
site: $(DEPS)
	mkdocs build -d $@
	cp -r spec type $@/

# Serve locally with MkDocs (starts watcher automatically)
serve: $(DEPS) watch
	mkdocs serve --livereload

# Build alias for backwards compatibility
build: site

# Lint check
lint: $(TYPOS)
	typos

# Deploy to production
publish: site
	cd $< && \
	  git init && \
	  git add -A && \
	  git commit -m 'Deploy to production' && \
	  git push -f $(REPO) HEAD:gh-pages
	$(RM) -r $<

# Generate pages from YAMLScript sources
pages:
	ys src/libraries.ys > docs/libraries.md

# Alias for pages (called by watcher)
update: pages
	@touch docs/libraries.md

# Watch src/ files and regenerate on change (runs in background)
watch: $(WATCHER-PID)

$(WATCHER-PID):
	watchmedo shell-command \
	  --patterns='*.ys;*.yaml' \
	  --recursive \
	  --command='make update' \
	  src/ & echo $$! > $@

# Stop the file watcher
watch-stop:
ifneq (,$(wildcard $(WATCHER-PID)))
	kill $$(< $(WATCHER-PID)) 2>/dev/null || true
	$(RM) $(WATCHER-PID)
endif

clean:: watch-stop

docs/%.md: src/%.ys src/%.yaml
	ys $< > $@
