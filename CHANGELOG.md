# Changelog
All notable changes to this project will be documented in this file

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html)

## [5.1.0]
### Added
- Added custom logger class
- Added `Mineshaft::RubyVersions` module which returns Ruby versions able to install
- Lots of new tests
- New `Mineshaft::Options` class that wraps around OptionParser

### Changed
- Output is a lot less verbose now, unless you pass in the `-v` flag
- Default Ruby version bumped to 3.4.1
- Updated Gemfile.lock; bundled with bundler 2.6.2
- Added emojis to output messages

## [5.0.0] 2021-05-11
- Environment no longer uses version.yaml; any version specified that is available to download from https://cache.ruby-lang.org can be downloaded now

## [4.2.0] 2020-09-14
- Updated the gem homepage to https://gitlab.com/ctesterman/mineshaft
- Added Ruby versions: 2.4.4, 2.4.5, 2.4.6, 2.4.7, 2.4.8, 2.4.9, 2.5.7, 2.7.1

## [4.1.0] 2019-11-25
- Added Ruby versions: 2.6.2, 2.6.3, 2.6.4, 2.6.5, 2.7.0-preview1, 2.7.0-preview2, 2.7.0-preview3

## [4.0.1] 2019-01-31
### Added
- Ruby version 2.6.1 support

## [4.0.0] 2019-01-01
### Added
- `ms env` will now display all installed global versions of Ruby, with the current version in use highlighted

### Deprecated
- `ms env` will replace `ms -i` - this option has been removed
- `-r` no longer works; Ruby version is added after either the `install` or `env` keyword
- `-g` has been removed as well. To install global run `ms install <VERSION_NUMBER>`

### Fixed
- `-n` works now and will successfully install Ruby without OpenSSL

## [3.1.0] 2018-12-07
### Added
- Support for Ruby version 2.6.0-rc1

### Fixes
- Fixed issue with tar reader not detecting directory within tar archive

## [2.1.0] 2018-07-08
### Added
- TODO: When a new global Ruby version is installed, the latest Mineshaft gem will be installed as well
- `-i` flag added; shows all installed global Rubies
- Tests added for `Mineshaft::Date`, `Mineshaft::Installer`, `Mineshaft::ActivateTemplate`

## [2.0.0] 2018-07-06
### Changed
- To run the tool, you must now use `ms` instead of `mineshaft` in your terminal window

### Added
- Can now use the `use` keyword to switch between global environments

## [1.3.1] 2018-07-04
### Fixes
- Regression fix - non-global environments can now be created again without error

## [1.3.0] 2018-07-03
### Added
- All previous Ruby versions are now available to install
- Added `list` keyword, which lists the latest ten Ruby versions available for install
- Added `reload` keyword, which allows binaries from current global Ruby version to be reloaded into the `bin` directory

## [1.2.0] - 2018-07-02
### Added
- Globally installed versions of Ruby: 
  - Correctly update the PATH variable by adding a line to .bash_profile
  - Installed in ~/.mineshaft
  - Symlinks are created from the global install to ~/.mineshaft/bin
- Added 2.6.0-preview1 and 2.6.0-preview2 install options
- Added CHANGELOG.md

### Changed
- Global installs are now denoted by a `-g` flag instead of using the `global` keyword.
- OpenSSL is now assumed to be installed in `/usr/local/opt/openssl`; the documentation is updated to recommend users to have OpenSSL installed prior to using Mineshaft
