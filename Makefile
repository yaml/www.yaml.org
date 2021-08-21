SHELL := bash

default:

publish: build
	git -C gh-pages add -A .
	git -C gh-pages commit --allow-empty -m 'Publish yaml.org -- $(shell date)'
	git -C gh-pages push origin gh-pages
	rm -fr gh-pages

build: gh-pages
	rm -fr $</*
	cp -r *.html css img spec type gh-pages/
	echo yaml.org > $</CNAME

gh-pages:
	@git branch --track $@ origin/$@ 2>/dev/null || true
	git worktree add -f $@ $@

clean:
	rm -fr gh-pages
