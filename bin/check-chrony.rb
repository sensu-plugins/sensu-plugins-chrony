#!/usr/bin/env ruby
#
# check-chrony.rb
#
# Author: Matteo Cerutti <matteo.cerutti@hotmail.co.uk>
#

require 'sensu-plugin/check/cli'
require 'socket'
require 'json'

class CheckChrony < Sensu::Plugin::Check::CLI
  option :chronyc_cmd,
         :description => "Path to chronyc executable (default: /usr/bin/chronyc)",
         :short => "-c <PATH>",
         :long => "--chronyc-cmd <PATH>",
         :default => "/usr/bin/chronyc"

  option :warn_offset,
         :description => "Warn if OFFSET exceeds current offset (ms)",
         :long => "--warn-offset <OFFSET>",
         :proc => proc(&:to_f),
         :default => 50

  option :crit_offset,
         :description => "Critical if OFFSET exceeds current offset (ms)",
         :long => "--crit-offset <OFFSET>",
         :proc => proc(&:to_f),
         :default => 100

  option :warn_stratum,
         :description => "Warn if STRATUM exceeds current stratum",
         :long => "--warn-stratum <STRATUM>",
         :proc => proc(&:to_i),
         :default => 10

  option :crit_stratum,
         :description => "Critical if STRATUM exceeds current stratum",
         :long => "--crit-stratum <STRATUM>",
         :proc => proc(&:to_i),
         :default => 16

  option :dryrun,
         :description => "Do not send events to sensu client socket",
         :long => "--dryrun",
         :boolean => true,
         :default => false

  def initialize()
    super
  end

  def send_client_socket(data)
    if config[:dryrun]
      puts data.inspect
    else
      sock = UDPSocket.new
      sock.send(data + "\n", 0, "127.0.0.1", 3030)
    end
  end

  def send_ok(check_name, msg)
    event = {"name" => check_name, "status" => 0, "output" => "OK: #{msg}"}
    send_client_socket(event.to_json)
  end

  def send_warning(check_name, msg)
    event = {"name" => check_name, "status" => 1, "output" => "WARNING: #{msg}"}
    send_client_socket(event.to_json)
  end

  def send_critical(check_name, msg)
    event = {"name" => check_name, "status" => 2, "output" => "CRITICAL: #{msg}"}
    send_client_socket(event.to_json)
  end

  def send_unknown(check_name, msg)
    event = {"name" => check_name, "status" => 3, "output" => "UNKNOWN: #{msg}"}
    send_client_socket(event.to_json)
  end

  def run
    stratum = nil
    offset = nil
    status = nil

    %x[#{config[:chronyc_cmd]} tracking].each_line do |line|
      case line.downcase
        when /^stratum\s*:\s*(\d+)$/
          stratum = $1.to_i
        when /^last offset\s*:\s*(-?[.\d]+)\s*seconds$/
          # convert from seconds to milliseconds
          offset = $1.to_f * 1000
        when /^leap status\s*:\s*(.*?)$/
          status = $1
      end
    end

    if stratum
      check_name = "chrony-stratum"
      msg = "NTP stratum is #{stratum}"

      if stratum >= config[:crit_stratum]
        msg += ", expected < #{config[:crit_stratum]}"
        send_critical(check_name, msg)
      elsif stratum >= config[:warn_stratum]
        msg += ", expected < #{config[:warn_stratum]}"
        send_critical(check_name, msg)
      else
        send_ok(check_name, msg)
      end
    else
      send_unknown(check_name, "Failed to look up NTP stratum")
    end

    if offset
      check_name = "chrony-offset"
      msg = "NTP offset is #{offset.round(4)}ms"

      if offset >= config[:crit_offset] or offset <= -config[:crit_offset]
        msg += ", expected > -#{config[:crit_offset]} and < #{config[:crit_offset]}"
        send_critical(check_name, msg)
      elsif offset >= config[:warn_offset] or offset < -config[:warn_offset]
        msg += ", expected > -#{config[:crit_offset]} and < #{config[:warn_offset]}"
        send_critical(check_name, msg)
      else
        send_ok(check_name, msg)
      end
    else
      send_unknown(check_name, "Failed to look up NTP offset")
    end

    if status
      msg = "NTP status is '#{status}'"

      if status != "normal"
        msg += ", expected 'Normal'"
        critical(msg)
      else
        ok(msg)
      end
    else
      unknown("Failed to look up NTP status")
    end
  end
end
