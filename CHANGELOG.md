# Change Log
This project adheres to [Semantic Versioning](http://semver.org/).

This CHANGELOG follows the format listed [here](https://github.com/sensu-plugins/community/blob/master/HOW_WE_CHANGELOG.md)

## [Unreleased]

### Breaking Changes
- Remove support for old Ruby (< 2.3)
- Bump sensu-plugin dependency from ~> 2.0 to ~> 4.0

### Changed
- Updated bundler dependancy to '~> 2.1'
- Updated rubocop dependency to '~> 0.81.0'
- Remediated rubocop issues
- Updated rake dependency to '~> 13.0'

## [1.0.1] - 2018-05-03
### Fixed
- Fixes "undefined method `empty?"` (@jwatroba)

## [1.0.0] - 2018-01-04
### Breaking Change
- remove ruby < 2.0 support (@majormoses)
- require `sensu-plugin` 2.0 (@majormoses)

### Added
- github templates (@majormoses)
- links to changelog guidelines (@majormoses)
- badges to README (@majormoses)
- various misc development dependencies (@majormoses)

### Changed
- standard gemspec (@majormoses)
- appease the cops (@majormoses)
- standard Rakefile (@majormoses)

## [0.0.9] - 2016-04-05
### Added
- fixed metrics key naming (@vervas)

## [0.0.8] - 2016-04-04
### Added
- adding metrics plugin (@vervas)

## [0.0.7] - 2016-01-18
### Added
- fixing regex

## [0.0.6] - 2016-01-18
### Added
- last offset regex should match both - and +

## [0.0.5] - 2016-01-14
### Added
- Added --handlers command line option

## [0.0.4] - 2016-01-14
### Added
- not using config[:handler]

## [0.0.3] - 2015-12-28
### Added
- Rounding offset

## [0.0.2] - 2015-12-28
### Added
- Casting thresholds to float

## [0.0.1] - 2015-12-28
### Added
- Initial release

[Unreleased]: https://github.com/sensu-plugins/sensu-plugins-ntp/compare/1.0.1...HEAD
[1.0.1]: https://github.com/sensu-plugins/sensu-plugins-ntp/compare/1.0.0...1.0.1
[1.0.0]: https://github.com/sensu-plugins/sensu-plugins-ntp/compare/0.0.10...1.0.0
[0.0.10]: https://github.com/sensu-plugins/sensu-plugins-ntp/compare/0.0.9...0.0.10
[0.0.9]: https://github.com/sensu-plugins/sensu-plugins-ntp/compare/0.0.8...0.0.9
[0.0.8]: https://github.com/sensu-plugins/sensu-plugins-ntp/compare/0.0.7...0.0.8
[0.0.7]: https://github.com/sensu-plugins/sensu-plugins-ntp/compare/0.0.6...0.0.7
[0.0.6]: https://github.com/sensu-plugins/sensu-plugins-ntp/compare/0.0.5...0.0.6
[0.0.5]: https://github.com/sensu-plugins/sensu-plugins-ntp/compare/0.0.4...0.0.5
[0.0.4]: https://github.com/sensu-plugins/sensu-plugins-ntp/compare/0.0.3...0.0.4
[0.0.3]: https://github.com/sensu-plugins/sensu-plugins-ntp/compare/0.0.2...0.0.3
[0.0.2]: https://github.com/sensu-plugins/sensu-plugins-ntp/compare/0.0.1...0.0.2
[0.0.1]: https://github.com/sensu-plugins/sensu-plugins-ntp/compare/00e3dfb1d044946ec5465f7075dce532bbb60cff...0.0.1
