Contributing to www.yaml.org
============================

The upkeep of http://www.yaml.org is a community project. You can easily
contribute! Just fork, make changes and send us a Pull Request.

NOTE: for changes to `index.html`, please target your PR to the `gh-pages`
branch directly. This is necessary until the process of generating
`gh-pages` is fixed.

This git repo is hosted at: https://github.com/yaml/www.yaml.org

Please file issues and pull requests here:
https://github.com/yaml/www.yaml.org/issues

If you want to chat about YAML or this site, drop by #yaml on irc.freenode.net

## Building the site locally

The website is hosted by GitHub pages using the files under the `docs/`
directory. Do not edit those files by hand. Edit the files under `src/` and
then run `make clean all`.

### Build Dependencies

* git
* docker
* make
* perl
