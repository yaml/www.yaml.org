Contributing to www.yaml.org
============================

The upkeep of http://www.yaml.org is a community project. You can easily
contribute! Just fork, make changes and send us a Pull Request.

## Use gh-pages branch

NOTE: for changes to `index.html`, please target your PR to the `gh-pages`
branch directly. This is necessary until the process of generating
`gh-pages` is fixed.

## Adding a YAML library to index.html

Thanks for adding a library we don't yet know about! Please help making
the list of libraries more useful.

Please note that it makes it easier to review it the more information is
provided.  The linked library homepage should ideally have the following
information:

* The implemented YAML version(s) (1.0, 1.1, 1.2)
* How complete the YAML version is implemented; what it doesn't do
* Which schemas are implemented. See [this list of
  schemas](https://perlpunk.github.io/yaml-test-schema/schemas.html). For YAML
  1.2 this should at least be the Core Schema. If it doesn't do resolving
  (booleans, integers etc.) at all, this information should ideally also
  be on the homepage.
* Tests/CI: Does the lib use the official
  [yaml-test-suite](https://github.com/yaml/yaml-test-suite)? Or does it have
  its own test cases? Are they linked from the Homepage?

The list of YAML libraries is growing, and they are all very different, so
it's important that people can find essential information about the library
at one glance.

If you are the author or know the library well, would you consider adding
it to the docker [yaml-runtimes](https://github.com/yaml/yaml-runtimes), which
is the base for the [yaml-test-matrix](https://matrix.yaml.io/)?
This helps making visible how complete the library is.

## About, Contact

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
