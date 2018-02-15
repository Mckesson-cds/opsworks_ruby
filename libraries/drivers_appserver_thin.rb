# frozen_string_literal: true

module Drivers
  module Appserver
    class Thin < Drivers::Appserver::Base
      adapter :thin
      allowed_engines :thin
      output filter: %i[max_connections max_persistent_connections timeout worker_processes]

      def appserver_config
        'thin.yml'
      end

      # This is the command used to start the thin server. The ROOT_PATH
      # environment variable gets interpolated inside the rendered service
      # script, so the braces need to be escaped here to avoid early
      # interpolation.
      def appserver_command
        "thin -C \#{ROOT_PATH}/shared/config/thin.yml" # rubocop:disable Lint/InterpolationCheck
      end
    end
  end
end
