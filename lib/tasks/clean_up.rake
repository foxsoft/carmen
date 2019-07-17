namespace :clean_up do
  desc "Deletes any messages with a spammed_at value older than 30 days"
  task spammed_messages: :environment do
    Message.spam_to_delete(&:destroy!)
  end
end
