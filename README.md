# Sensu plugin for monitoring Chrony NTP

A sensu plugin to monitor Chrony NTP.

The plugin generates multiple OK/WARN/CRIT/UNKNOWN check events via the sensu client socket (https://sensuapp.org/docs/latest/clients#client-socket-input) so that you do not miss state changes when monitoring offset, stratum and status.

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
