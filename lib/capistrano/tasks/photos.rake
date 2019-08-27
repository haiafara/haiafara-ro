# frozen_string_literal: true

namespace :photos do
  task :reprocess do
    on roles(:app) do
      within current_path.to_s do
        with rails_env: fetch(:stage).to_s do
          execute :rake, 'photos:reprocess'
        end
      end
    end
  end
end
