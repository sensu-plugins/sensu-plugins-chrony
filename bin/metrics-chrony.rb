#! /usr/bin/env ruby
# frozen_string_literal: false

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
         default: "#{Socket.gethostname}.chronystats"

  def run
    # #YELLOW
    unless config[:host] == 'localhost'
      config[:scheme] = config[:host]
    end

    chronystats = read_chronystats
    critical "Failed to get chronycstats from #{config[:host]}" if chronystats.empty?
    metrics = {
      config[:scheme] => chronystats
    }
    metrics.each do |name, stats|
      stats.each do |key, value|
        output([name, key].join('.'), value)
      end
    end
    ok
  end

  def read_chronystats
    num_val_pattern = /^[-+]?\d+(\.\d+)?\s/

    `chronyc tracking`.each_line.each_with_object({}) do |line, hash|
      key, val = line.split(/\s*:\s*/)
      matched = val.match(num_val_pattern) || (next hash)
      number, fraction = matched.to_a
      number = fraction ? number.to_f : number.to_i
      number = - number if /slow/ =~ val # for system time
      hash[snakecase(key)] = number
    end
  end

  def snakecase(str)
    str.downcase.tr(' ', '_').gsub(/[()]/, '')
  end
end
