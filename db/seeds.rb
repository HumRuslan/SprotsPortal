if Rails.env.development?
  require 'factory_bot_rails'
  Dir[File.join(Rails.root, 'db', 'seeds', '*.rb')].sort.each { |seed| load seed }
end

if Rails.env.production?
  load File.join(Rails.root, 'db', 'seeds', 'user.rb')
end
