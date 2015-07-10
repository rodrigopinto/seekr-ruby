require "seekr/client"
require "seekr/configuration"
require "seekr/errors"
require "seekr/monitor"
require "seekr/occurrence"
require "seekr/report"
require "seekr/version"

require 'active_support/core_ext/time'

Time.zone = "Brasilia"

module Seekr

  def self.configure(&block)
    yield configuration
  end

  def self.configuration
    @configuration ||= Seekr::Configuration.new
  end

  def self.api_key
    configuration.api_key
  end

  def self.api_secret
    configuration.api_secret
  end

  def self.reset
    @configuration = nil
  end
end
