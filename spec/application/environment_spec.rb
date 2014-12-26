RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
  config.order = "random"
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.full_backtrace = true
end

describe 'Application', :application do
  it 'dies when loading Hangar in non-test environment' do
    ENV['RACK_ENV'] = 'production'
    ENV['RAILS_ENV'] = 'production'
    expect { defined? Hangar }.to be_true
    expect {
      require File.expand_path("../../dummy/config/environment", __FILE__)
    }.to_not raise_error{Hangar::BadEnvironmentError}
  end

  it 'allows environments specified in configuration' do
    ENV['RACK_ENV'] = 'additional_test_env'
    ENV['RAILS_ENV'] = 'additional_test_env'
    expect { defined? Hangar }.to be_true
    Hangar.acceptable_environments = %w(test additional_test_env)
    expect {
      require File.expand_path("../../dummy/config/environment", __FILE__)
    }.not_to raise_error{Hangar::BadEnvironmentError}
  end

  it 'defaults clean_strategy to deletion' do
    expect(Hangar.clean_strategy).to eq :deletion
  end
end
