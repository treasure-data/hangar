require "hangar/engine"
require 'hangar/constraint'
require 'database_cleaner'

module Hangar
  BadEnvironmentError = Class.new(StandardError)

  mattr_writer :do_not_delete
  mattr_accessor :clean_strategy
  self.clean_strategy = :deletion
  mattr_accessor :acceptable_environments
  self.acceptable_environments = %w(test)

  def self.do_not_delete
    Array.wrap(@@do_not_delete)
  end

  def validate_environment
    self.acceptable_environments.include?(Rails.env) or raise BadEnvironmentError, "Hangar should only be used in #{self.acceptable_environments.to_sentence} environment"
  end
  module_function :validate_environment
end

