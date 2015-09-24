require 'spec_helper'
require 'sidekiq/api'

class TestWorker
  include Sidekiq::Worker
  def perform(num)
  end
end

describe "Sidekiq::Approval" do

  let(:worker) { TestWorker }
  let(:non_approval_args) { { require_approval: false } }
  let(:approval_args) { { require_approval: true } }

  it 'should add jobs to regular queue' do
    expect_any_instance_of(worker).to receive(:perform)
    worker.perform_async(non_approval_args)
    worker.drain
  end

  it 'should add jobs to approval queue' do
    expect_any_instance_of(worker).not_to receive(:perform)
    worker.perform_async(approval_args)
    worker.drain
  end

end

