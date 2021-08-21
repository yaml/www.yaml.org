SHELL := bash

default:

publish: build
	git -C gh-pages add -A .
	git -C gh-pages commit --allow-empty -m 'Publish yaml.org -- $(shell date)'
	git -C gh-pages lol -10
	git -C gh-pages push origin gh-pages

build: gh-pages
	find gh-pages/ -mindepth 1 -maxdepth 1 | \
	    grep -Ev '/(\.git|CNAME)$$' | \
	    xargs rm -fr
	cp -r *.html *.css css img spec type gh-pages/

gh-pages:
	@git branch --track $@ origin/$@ 2>/dev/null || true
	git worktree add -f $@ $@

clean:
	rm -fr gh-pages
