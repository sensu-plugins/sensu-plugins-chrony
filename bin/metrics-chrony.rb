#! /usr/bin/env ruby
#  encoding: UTF-8
#
#   metrics-chrony
#
# DESCRIPTION:
#
# OUTPUT:
#   metric data
#
# PLATFORMS:
#   Linux
#
# DEPENDENCIES:
#   gem: sensu-plugin
#   gem: socket
#
# USAGE:
#
# NOTES:
#

require 'sensu-plugin/metric/cli'
require 'socket'

class ChronyMetrics < Sensu::Plugin::Metric::CLI::Graphite
  option :host,
         description: 'Target host',
         short: '-h HOST',
         long: '--host HOST',
         default: 'localhost'

  option :scheme,
         description: 'Metric naming scheme, text to prepend to metric',
         short: '-s SCHEME',
         long: '--scheme SCHEME',
         default: Socket.gethostname

  def run
    # #YELLOW
    unless config[:host] == 'localhost'
      config[:scheme] = config[:host]
    end

    chronystats = get_chronystats(config[:host])
    critical "Failed to get chronycstats from #{config[:host]}" if chronystats.empty?
    metrics = {
      chronystats: chronystats
    }
    metrics.each do |name, stats|
      stats.each do |key, value|
        output([config[:scheme], name, key].join('.'), value)
      end
    end
    ok
  end

  def get_chronystats(host)
    key_pattern = Regexp.compile(
      [
        "Stratum",
        "Last offset",
        "RMS offset",
        "Frequency",
        "Residual freq",
        "Skew",
        "Root delay",
        "Root dispersion",
        "Update interval"
      ].join('|'))
    num_val_pattern = /[\-\+]?[\d]+(\.[\d]+)?/
    pattern = /^(#{key_pattern})\s*:\s*(#{num_val_pattern}).*$/

    `chronyc tracking`.scan(pattern).reduce({}) do |hash, parsed|
      key, val, fraction = parsed
      hash[key.downcase.tr(" ", "_")] = fraction ? val.to_f : val.to_i
      hash
    end
  end
end
