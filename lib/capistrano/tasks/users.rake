# frozen_string_literal: true

namespace :users do
  task :make_admin, :email do
    on roles(:app) do
      within current_path.to_s do
        with rails_env: fetch(:stage).to_s do
          execute :rake, "make_admin[#{args[:email]}]"
        end
      end
    end
  end
end
