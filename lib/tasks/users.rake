# frozen_string_literal: true

namespace :users do
  desc 'Make user an admin'
  task :make_admin, [:email] => [:environment] do |_t, args|
    user = User.find_by(email: args[:email])
    user.update_attribute(:admin, true)
  end
end
