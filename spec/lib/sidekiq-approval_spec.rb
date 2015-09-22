require 'spec_helper'
require 'sidekiq/api'
require 'pry'

class TestWorker
  include Sidekiq::Worker
  @queue = 'dummy'

  def perform(num)
    binding.pry
  end

end

describe "Sidekiq::Approval" do

  before do
    Sidekiq::Queue.new("dummy").clear
    Sidekiq::Queue.new("approval_required")

    Sidekiq.redis do |conn|
      conn.del('pending_jobs')
    end
  end

  let(:worker) { TestWorker }
  let(:non_approval_args) { { require_approval: false } }
  let(:approval_args) { { require_approval: true } }

  it 'should add jobs to regular queue' do
    expect_any_instance_of(worker).to receive(:perform)
    worker.perform_async(non_approval_args)
    #worker.drain
  end

  it 'should add jobs to approval queue' do
    expect_any_instance_of(worker).not_to receive(:perform)
    worker.perform_async(approval_args)
    #worker.drain
  end

  context 'approved jobs' do
    it 'should remove job from approval queue'
    it 'should add job to regular queue'
  end

  context 'rejected jobs' do
    it 'should remove job from approval queue'
    it 'should add job to regular queue'
  end

end

