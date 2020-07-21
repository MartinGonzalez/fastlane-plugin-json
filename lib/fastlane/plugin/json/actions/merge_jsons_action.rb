# frozen_string_literal: true

require "json"

module Fastlane
  module Actions
    class MergeJsonsAction < Action
      def self.run(params)
        jsons_paths = params[:jsons_paths]
        output_path = params[:output_path]
        @is_verbose = params[:verbose]

        print_params(params) if @is_verbose
        put_error!("jsons_path cannot be empty ❌") if jsons_paths.empty?

        hashes = jsons_paths.map do |json_path|
          put_error!("json_path: #{json_path} is not valid ❌") unless File.exist?(json_path)
          json_content = File.read(File.expand_path(json_path))
          begin
            JSON.parse(json_content, symbolize_names: true)
          rescue
            put_error!("File at path #{json_path} has invalid content. ❌")
          end
        end

        merged_hash = hashes.reduce({}, :merge)

        write_hash_at(output_path, merged_hash) unless output_path.to_s.empty?

        merged_hash
      end

      def self.write_hash_at(output_path, hash)
        file_path_expanded = File.expand_path(output_path)
        file_dir = File.dirname(file_path_expanded)
        Dir.mkdir(file_dir) unless File.directory?(file_dir)

        begin
          File.open(output_path, "w") { |f| f.write(JSON.pretty_generate(hash)) }
        rescue
          put_error!("Failed to write json at #{output_path}. ❌")
        end
      end

      def self.put_error!(message)
        UI.user_error!(message)
        raise StandardError, message
      end

      def self.description
        "Merge a group of jsons files and expose a hash with symbolized names as result. Last json predominate over the rest"
      end

      def self.details
        "Use this action to merge jsons files and access to it as Hash with symbolized names. Also you can set the output_path to save the result"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :jsons_paths,
                                       description: "Array of json files paths",
                                       type: Array,
                                       optional: false,
                                       verify_block: proc do |value|
                                         UI.user_error!("You must set jsons_paths") unless value && !value.empty?
                                       end),
          FastlaneCore::ConfigItem.new(key: :output_path,
                                       description: "Output path where result will be saved",
                                       type: String,
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :verbose,
                                       description: "verbose",
                                       optional: true,
                                       default_value: false,
                                       type: Boolean)

        ]
      end

      def self.print_params(options)
        table_title = "Params for merge_json #{Fastlane::Json::VERSION}"
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
