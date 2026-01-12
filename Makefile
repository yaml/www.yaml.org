# ===== makeplus/makes framework =====
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

# ===== Deployment repositories =====
MAIN-REPO  ?= git@github.com:yaml/www.yaml.org
STAGE-REPO ?= git@github.com:yaml/stage.yaml.org

# ===== Clean targets =====
MAKES-CLEAN := site material main-site stage-site
MAKES-REALCLEAN := $(PYTHON-VENV)
MAKES-DISTCLEAN := .cache

# ===== Main targets =====
DEPS := $(PYTHON-VENV)

default::

deps: line1 $(DEPS) line2

# Build main site (production)
main-site: lint $(DEPS)
	venv/bin/mkdocs build -d $@
	cp -r spec type $@/

# Build stage site (with stage CNAME)
stage-site: lint $(DEPS)
	venv/bin/mkdocs build -d $@
	cp -r spec type $@/
	echo 'stage.yaml.org' > $@/CNAME

# Serve locally with MkDocs
serve: $(DEPS)
	venv/bin/mkdocs serve

# Build alias for backwards compatibility
build: main-site

# Lint check
lint: $(TYPOS)
	typos

# Deploy to stage
stage: stage-site
	cd $< && \
	  git init && \
	  git add -A && \
	  git commit -m 'Deploy to staging' && \
	  git push -f $(STAGE-REPO) HEAD:main
	$(RM) -r $<

# Deploy to production
publish: main-site
	cd $< && \
	  git init && \
	  git add -A && \
	  git commit -m 'Deploy to production' && \
	  git push -f $(MAIN-REPO) HEAD:gh-pages
	$(RM) -r $<

# ===== Utility targets =====
material: $(PYTHON-VENV)
	ln -s $</lib/python*/site-packages/material $@

pip-install: $(PYTHON-VENV)
ifeq (,$(m))
	@echo 'm=<module> is not set'
	@exit 1
endif
	pip install $m
	pip freeze > requirements.txt

freeze: $(PYTHON-VENV)
	pip freeze > requirements.txt

line1 line2:
	@echo =======================================================================

venv: $(PYTHON-VENV)
	@echo $<
