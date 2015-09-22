# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sidekiq-approval/version'

Gem::Specification.new do |spec|
  spec.name          = "sidekiq-approval"
  spec.version       = Sidekiq::Plugins::Approval::VERSION
  spec.authors       = ["Mac Martine"]
  spec.email         = ["mac.martine@gmail.com"]
  spec.summary       = %q{Adds an optional approval process to Sidekiq jobs.}
  spec.description   = %q{Adds an optional approval process to Sidekiq jobs.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  #spec.add_runtime_dependency "sidekiq", branch: "master"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rspec", "~> 3.2.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-nav"
end
