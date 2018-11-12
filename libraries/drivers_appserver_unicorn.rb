# frozen_string_literal: true

module Drivers
  module Appserver
    class Unicorn < Drivers::Appserver::Base
      adapter :unicorn
      allowed_engines :unicorn
      output filter: %i[
        backlog delay preload_app tcp_nodelay tcp_nopush tries timeout worker_processes
        port
      ]

      def appserver_config
        'unicorn.conf'
      end

      # This is the command used to start the unicorn_rails server. The
      # DEPLOY_ENV environment variable gets interpolated inside the rendered
      # service script, so the braces need to be escaped here to avoid early
      # interpolation.
      def appserver_command
        "unicorn_rails --env \#{DEPLOY_ENV} --daemonize -c \#{ROOT_PATH}/shared/config/unicorn.conf"
      end
    end
  end
end
