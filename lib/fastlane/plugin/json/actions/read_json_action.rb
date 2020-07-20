# frozen_string_literal: true

require "json"

module Fastlane
  module Actions
    class ReadJsonAction < Action
      def self.run(params)
        json_path = params[:json_path]
        @is_verbose = params[:verbose]

        print_params(params) if @is_verbose

        unless File.file?(json_path)
          put_error!("File at path #{json_path} does not exist. Verify that the path is correct ❌")
          return nil
        end

        json_content = File.read(json_path)
        begin
          JSON.parse(json_content, symbolize_names: true)
        rescue
          put_error!("File at path #{json_path} has invalid content. ❌")
        end
      end

      def self.put_error!(message)
        UI.user_error!(message)
      end

      def self.description
        "Read a json file and expose a hash with symbolized names as result"
      end

      def self.details
        "Use this action to read a json file and access to it as Hash with symbolized names"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :json_path,
                                       description: "Path to json file",
                                       is_string: true,
                                       optional: false,
                                       verify_block: proc do |value|
                                         UI.user_error!("You must set json_path pointing to a json file") unless value && !value.empty?
                                       end),
          FastlaneCore::ConfigItem.new(key: :verbose,
                                       description: "verbose",
                                       optional: true,
                                       type: Boolean)

        ]
      end

      def self.print_params(options)
        table_title = "Params for read_json #{Fastlane::Json::VERSION}"
        FastlaneCore::PrintTable.print_values(config: options,
                                              hide_keys: [],
                                              title: table_title)
      end

      def self.return_value
        "Hash"
      end

      def self.authors
        ["Martin Gonzalez"]
      end

      def self.is_supported?(_platform)
        true
      end
    end
  end
end
