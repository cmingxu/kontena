require_relative 'common'

module Kontena::Cli::Stacks
  class UpdateCommand < Clamp::Command
    include Kontena::Cli::Common
    include Kontena::Cli::GridOptions
    include Common

    parameter "NAME", "Service name"

    option ['-f', '--file'], 'FILE', 'Specify an alternate Kontena stack file', attribute_name: :filename, default: 'kontena.yml'

    def execute
      require_api_url
      token = require_token
      require_config_file(filename)
      stack = stack_from_yaml(filename)
      update_stack(token, stack)
    end

    def update_stack(token, stack)
      client(token).put("stacks/#{current_grid}/#{name}", stack)
    end
  end
end