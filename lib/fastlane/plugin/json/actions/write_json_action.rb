# frozen_string_literal: true

require "json"

module Fastlane
  module Actions
    class WriteJsonAction < Action
      def self.run(params)
        hash = params[:hash]
        file_path = params[:file_path]
        @is_verbose = params[:verbose]
        print_params(params) if @is_verbose

        put_error!("file_path: value cannot be nil or empty") if file_path.nil? || file_path.empty?
        put_error!("hash: value cannot be nil") if hash.nil?

        file_path_expanded = File.expand_path(file_path)
        file_dir = File.dirname(file_path_expanded)
        Dir.mkdir(file_dir) unless File.directory?(file_dir)

        begin
          File.open(file_path, "w") do |f|
            f.write(JSON.pretty_generate(hash))
          end
        rescue
          put_error!("File at path #{json_path} has invalid content. ❌")
        end
      end

      def self.put_error!(message)
        UI.user_error!(message)
        raise StandardError, message
      end

      def self.description
        "Write a json file from a hash at the provided path"
      end

      def self.details
        "Use this action to serialize a hash into a json file in a provided path."
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :hash,
                                       description: "Hash that you want to save as a json file",
                                       optional: false,
                                       type: Hash,
                                       verify_block: proc do |value|
                                         UI.user_error!("You must set hash: parameter") unless value && !value.empty?
                                       end),
          FastlaneCore::ConfigItem.new(key: :file_path,
                                       description: "Path where you want to save your json",
                                       is_string: true,
                                       optional: false,
                                       verify_block: proc do |value|
                                         UI.user_error!("You must set file_path: parameter") unless value && !value.empty?
                                       end),
          FastlaneCore::ConfigItem.new(key: :verbose,
                                       description: "verbose",
                                       optional: true,
                                       type: Boolean)
        ]
      end

      def self.print_params(options)
        table_title = "Params for write_json #{Fastlane::Json::VERSION}"
        FastlaneCore::PrintTable.print_values(config: options,
                                              hide_keys: [],
                                              title: table_title)
      end

      def self.return_value
        "Nothing"
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
