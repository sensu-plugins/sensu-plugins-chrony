# Sensu plugin for monitoring Chrony NTP


[![Build Status](https://travis-ci.org/sensu-plugins/sensu-plugins-chrony.svg?branch=master)](https://travis-ci.org/sensu-plugins/sensu-plugins-chrony)
[![Gem Version](https://badge.fury.io/rb/sensu-plugins-chrony.svg)](https://badge.fury.io/rb/sensu-plugins-chrony)
[![Code Climate](https://codeclimate.com/github/sensu-plugins/sensu-plugins-chrony/badges/gpa.svg)](https://codeclimate.com/github/sensu-plugins/sensu-plugins-chrony)
[![Test Coverage](https://codeclimate.com/github/sensu-plugins/sensu-plugins-chrony/badges/coverage.svg)](https://codeclimate.com/github/sensu-plugins/sensu-plugins-chrony)
[![Dependency Status](https://gemnasium.com/sensu-plugins/sensu-plugins-chrony.svg)](https://gemnasium.com/sensu-plugins/sensu-plugins-chrony)
[![Community Slack](https://slack.sensu.io/badge.svg)](https://slack.sensu.io/badge)

A sensu plugin to monitor Chrony NTP. There is also a metrics plugin for collecting things like offset, delay etc.

The plugin generates multiple OK/WARN/CRIT/UNKNOWN check events via the sensu client socket (https://sensuapp.org/docs/latest/clients#client-socket-input) so that you do not miss state changes when monitoring offset, stratum and status.

## Installation

System-wide installation:

    $ gem install sensu-plugins-chrony

Embedded sensu installation:

    $ /opt/sensu/embedded/bin/gem install sensu-plugins-chrony

## Files

* bin/check-chrony.rb
* bin/metrics-chrony.rb

## Usage

The plugin accepts the following command line options:

```
Usage: check-chrony.rb (options)
    -c, --chronyc-cmd <PATH>         Path to chronyc executable (default: /usr/bin/chronyc)
        --crit-offset <OFFSET>       Critical if OFFSET exceeds current offset (ms)
        --crit-stratum <STRATUM>     Critical if STRATUM exceeds current stratum
        --dryrun                     Do not send events to sensu client socket
        --handlers <HANDLERS>        Comma separated list of handlers
        --warn-offset <OFFSET>       Warn if OFFSET exceeds current offset (ms)
        --warn-stratum <STRATUM>     Warn if STRATUM exceeds current stratum
```

Use the --handlers command line option to specify which handlers you want to use for the generated events.

## Author
Matteo Cerutti - <matteo.cerutti@hotmail.co.uk>
