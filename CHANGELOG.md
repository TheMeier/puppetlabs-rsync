# Change log

All notable changes to this project will be documented in this file. The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/) and this project adheres to [Semantic Versioning](http://semver.org).

## [1.0.2](https://github.com/TheMeier/themeier-rsync/tree/1.0.2) (2019-02-19)

[Full Changelog](https://github.com/TheMeier/themeier-rsync/compare/v1.0.1...1.0.2)

### Added

- pdk convert [\#4](https://github.com/TheMeier/themeier-rsync/pull/4) ([TheMeier](https://github.com/TheMeier))

# Change Log

## [v1.0.1](https://github.com/TheMeier/puppetlabs-rsync/tree/v1.0.1) (2017-10-01)
[Full Changelog](https://github.com/TheMeier/puppetlabs-rsync/compare/v1.0.0...v1.0.1)


**Features:**

- Add $reverse\_lookup parameter to rsync::server::module


## [1.0.0](https://github.com/TheMeier/puppetlabs-rsync/tree/1.0.0) (2017-07-30)
[Full Changelog](https://github.com/TheMeier/puppetlabs-rsync/compare/v0.7.0...1.0.0)


### Summary

Major release. Code cleanup and documentation.
The documentation is published on https://themeier.github.io/puppetlabs-rsync/

**Breaking changes**
- All parameters to rsync::get and rsync::put wich are simple wrappers for rsync command-line switches have been removed! It's not very useful to have a parameter for each rsync command line switch. Instead put your desired command line options in a string and pass it to the $options parameter. The Following paramters were removed:
  - rsync::get
    - $purge
    - $recursive
    - $links
    - $hardlinks
    - $copylinks
    - $times
    - $include
    - $exclude
    - $exclude_first
    - $keyfile
    - $chown
    - $chmod
    - $logfile
  - rsync::put
    - $purge
    - $exclude
    - include
    - $exclude_first
    - $keyfile

- All yes/no on/off 1/0 true/false paramters have been converted to boolean paramters. This changes the following parameters
  - rsync::server
    - use_chroot
  - rsync::server::module
    - read_only
    - write_only
    - list
    - use_chroot
    - transfer_logging
    - ignore_nonreadable

- motd file functionallity was removed
- rsync::repo was removed

##2017-07-07 - Release 0.7.0

[Full Changelog](https://github.com/TheMeier/puppetlabs-rsync/compare/v0.6.3...v0.7.0)

### Summary
- add exclude_first parameter for rsync::get and rsync::put
- add logfile parameter to rsync::get
- use puppet-rspec-facts for tests
- replace legacy facts with new $facts hash
- use data types for all parameters

##2017-07-01 - Release 0.6.4
###Summary
- New paramter to set dont compress

##2017-05-11 - Release 0.6.3
###Summary
- New paramter to set uee chroot

##2017-04-13 - Release 0.6.2
###Summary
- Set conffile and service name for FreeBSD, https://github.com/puppetlabs/puppetlabs-rsync/pull/87
- New paramter to set syslog facility

##2017-02-08 - Release 0.6.1
###Summary
- New parameters
  - rsync::server::module
    - `$pre_xfer_exec`
    - `$post_xfer_exec`

##2017-01-05 - Release 0.6.0
###Summary
Force array type for array params of rsync::server::module.
In previous versions it was possible to pass string values for array params. The switch to epp
let to string values split by character

##2016-12-15 - Release 0.5.3
###Summary
This release replaces erb templates with epp templates

##2016-10-04 - Release 0.5.2
###Summary
This release improves test and metadata

####Features
- Add metadata_lint check
- Add os_supportt metadata
- Bound ranges for dependencies
- Add tags

##2016-10-05 - Release 0.5.1
###Summary
This release includes new parameters.

####Features
- New parameters
  - rsync::server::module
    - `$log_file`
    - `$ignore_nonreadable`


##2016-09-21 - Release 0.5.0
###Summary
This release includes several new parameters and puppet 4 support.

####Features
- Add SuSE and RedHat support
- New parameters
  - rsync
    - `$manage_package`
    - `$puts`
    - `$gets`
  - rsync::server
    - `port`
  - rsync::server::module
    - `transfer_logging`
    - `log_format`

####Bugfixes
- Fix testing
- Compatibility with puppet 4 and future parser


##2015-01-20 - Release 0.4.0
###Summary

This release includes several new parameters and improvements.

####Features
- Update `$include` and `$exclude` to support arrays
- Updated to use puppetlabs/concat instead of execs to build file!
- New parameters
  - rsync::get
    - `$options`
    - `$onlyif`
  - rsync::put
    - `$include`
    - `$options`
  - rsync::server::module
    - `$order`
    - `$refuse_options`

####Bugfixes
- Fix auto-chmod of incoming and outgoing files when `incoming_chmod` or `outgoing_chmod` is set to false

##2014-07-15 - Release 0.3.1
###Summary

This release merely updates metadata.json so the module can be uninstalled and
upgraded via the puppet module command.

##2014-06-18 - Release 0.3.0
####Features
- Added rsync::put defined type.
- Added 'recursive', 'links', 'hardlinks', 'copylinks', 'times' and 'include'
parameters to rsync::get.
- Added 'uid' and 'gid' parameters to rsync::server
- Improved support for Debian
- Added 'exclude' parameter to rsync::server::module

####Bugfixes
- Added /usr/local/bin to path for the rsync command exec.


##2013-01-31 - Release 0.2.0
- Added use_chroot parameter.
- Ensure rsync package is installed.
- Compatability changes for Ruby 2.0.
- Added execuser parameter to run command as specified user.
- Various typo and bug fixes.

##2012-06-07 - Release 0.1.0
- Initial release


\* *This Change Log was automatically generated by [github_changelog_generator](https://github.com/skywinder/Github-Changelog-Generator)*


\* *This Changelog was automatically generated by [github_changelog_generator](https://github.com/skywinder/Github-Changelog-Generator)*
