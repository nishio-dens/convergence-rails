require "convergence/rails/version"

module Convergence
  module Rails
    class Railtie < ::Rails::Railtie
      rake_tasks do
        load "tasks/database.rake"
      end
    end
  end
end
