#require "sidekiq-approval/version"
require 'sidekiq'

module Sidekiq
  class Approval

    APPROVAL_PREFIX = 'pending_approval'

    # Save job to approval queue
    # Read jobs waiting approval
    # Reject jobs
    # Approve jobs
    
    def call(workers, msg, queue)
      if msg['args'].first['require_approval']
        enqueue_for_approval(workers, msg, queue)
      else
        yield
      end
    end

    def enqueue_for_approval(workers, msg, queue)
      binding.pry
      #key = build_key

      Sidekiq.redis do |conn|
        conn.rpush("#{APPROVAL_PREFIX}:", msg)
      end
    end

    def self.pending_job_keys
      keys = Resque.redis.hkeys('APPROVAL_PREFIX')
      keys.map! { |key| Resque.decode(key) }
      keys.sort! { |a, b| a['id'] <=> b['id'] }
    end

    def approve

    end

    def reject

    end

    def remove_from_pending(key)
      Resque.redis.hdel('pending_jobs', key)
    end

  end

  class TestWorker
    include Sidekiq::Worker
    @queue = 'dummy'

    def perform(num)
      binding.pry
    end

  end

end


