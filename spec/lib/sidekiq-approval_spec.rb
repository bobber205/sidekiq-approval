require 'spec_helper'

class Job
  extend ::Sidekiq::Plugins::Approval

  @queue = 'dummy'

  def self.perform
  end
end

