require 'factory_bot_rails'

if Rails.env.development?
  Chewy.strategy(:atomic) do
    Dir[File.join(Rails.root, 'db', 'seeds', '*.rb')].sort.each { |seed| load seed }
  end
end

if Rails.env.production?
  load File.join(Rails.root, 'db', 'seeds', 'user.rb')
end
