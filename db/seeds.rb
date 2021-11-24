if Rails.env.development?
  require 'factory_bot_rails'
  Chewy.strategy(:atomic) do
    Dir[File.join(Rails.root, 'db', 'seeds', '*.rb')].sort.each { |seed| load seed }
  end
end

if Rails.env.production?
  load File.join(Rails.root, 'db', 'seeds', 'user.rb')
end
