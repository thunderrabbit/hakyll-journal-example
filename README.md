hakyll-journal-example
======================

This is an example site using
[Hakyll Journal](https://github.com/thunderrabbit/hakyll-journal), a
[Hakyll](http://jaspervdj.be/hakyll/) module for adding a journal/diary to
your static website.

Development
-----------

[Hakyll Journal](https://github.com/thunderrabbit/hakyll-journal) is currently
developed using [GHC](https://www.haskell.org/ghc/) `7.8.3` and should be
compatible with [Haskell Platform](https://www.haskell.org/platform/)
`2014.2.0.0`.

To setup `hakyll-journal-example` for development of Hakyll Journal, first
prepare a Hakyll Journal development environment and setup
`hakyll-journal-example` as follows:

1. `$ cd ~/projects`
2. `$ git clone https://github.com/thunderrabbit/hakyll-journal-example`
3. `$ cd hakyll-journal-example`
4. `$ git checkout -b develop`
5. `$ git branch --set-upstream develop origin/develop`
6. `$ git pull`
7. `$ cabal sandbox init`
8. `$ cabal sandbox add-source ~/projects/hakyll-journal`
9. `$ cabal install --only-dependencies`
10. `$ cabal build`
