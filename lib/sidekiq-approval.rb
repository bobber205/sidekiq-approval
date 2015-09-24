require 'sidekiq'

module Sidekiq
  class Approval

    APPROVAL_PREFIX = 'pending_approval'

    def call(workers, msg, queue)
      if msg['args'].first['require_approval']
        enqueue_for_approval(workers, msg, queue)
      else
        yield
      end
    end

    private

    def enqueue_for_approval(workers, msg, queue)
      Sidekiq.redis do |conn|
        conn.rpush("#{APPROVAL_PREFIX}", msg)
      end
    end

  end

  # TestWorker: Useful for experimenting in console
  class TestWorker
    include Sidekiq::Worker
    def perform(num)
    end
  end

end


