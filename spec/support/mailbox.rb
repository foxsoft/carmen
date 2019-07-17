# https://mikerogers.io/2019/05/20/testing-rails-action-mailbox-with-rspec.html
require 'action_mailbox/test_helper'

RSpec.configure do |config|
  config.include ActionMailbox::TestHelper, type: :mailbox
end
