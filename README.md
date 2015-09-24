# Sidekiq::Approval

Sidekiq::Approval is Sidekiq middleware (server-side), that can stop the processing of jobs, and save them off to be manually approved/rejected.

## How it works

Sidekiq::Approval is Sidekiq middleware. Before each job is run, it gets routed through this gem. If `require_approval: false`, or `require_approval` is not present, the job continues processing as normal. If `require_approval: false`, the job is not processed, and is instead saved to Redis, in a list named Sidekiq::Approval::APPROVAL_PREFIX ('require_approval').


## Installation

Add this line to your application's Gemfile:

    gem 'sidekiq-approval'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sidekiq-approval

## Usage

Add Sidekiq::Approval as server middleware in your application initializer:

```ruby
Sidekiq.configure_server do |config|
  config.server_middleware do |chain|
    chain.add Sidekiq::Approval
  end
end
```

Then pass in `require_approval: true` as an argument when enqueuing a job you want to mark for approval.

## Console

`rake console`

## Contributing

1. Fork it ( https://github.com/macmartine/sidekiq-approval/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
