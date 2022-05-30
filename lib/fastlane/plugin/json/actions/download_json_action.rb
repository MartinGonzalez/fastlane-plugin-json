# frozen_string_literal: true

require "net/http"
require "json"

module Fastlane
  module Actions
    class DownloadJsonAction < Action
      def self.run(params)
        json_url = params[:json_url]
        @is_verbose = params[:verbose]
        username = params[:username]
        password = params[:password]

        uri = URI(json_url)
        print_params(params) if @is_verbose
        puts("Downloading json from #{uri}") if @is_verbose

        begin
          Net::HTTP.start(uri.host, uri.port,
                          use_ssl: uri.scheme == 'https',
                          verify_mode: OpenSSL::SSL::VERIFY_NONE) do |http|

            request = Net::HTTP::Get.new(uri.request_uri)
            if !username.nil? && !username.empty? && !password.nil? && !password.empty?
              request.basic_auth(params[:username], params[:password])
            end

            response = http.request(request)
            JSON.parse(response.body, symbolize_names: true)
          end
        rescue JSON::ParserError
          puts_error!("Downloaded json has invalid content ❌")
        rescue => exception
          puts_error!("Failed to download json. Message: #{exception.message} ❌")
        end
      end

      def self.puts_error!(message)
        UI.user_error!(message)
        raise StandardError, message
      end

      def self.description
        "Downloads a json file and expose a hash with symbolized names as result"
      end

      def self.details
        "Use this action to download a json file and access to it as Hash with symbolized names"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :json_url,
                                       description: "Url to json file",
                                       is_string: true,
                                       optional: false,
                                       verify_block: proc do |value|
                                         UI.user_error!("You must set json_url pointing to a json file") unless value && !value.empty?
                                       end),
          FastlaneCore::ConfigItem.new(key: :username,
                                       description: "Basic auth username to download",
                                       optional: true,
                                       is_string: true,
                                       default_value: nil),
          FastlaneCore::ConfigItem.new(key: :password,
                                       description: "Basic auth password to download",
                                       optional: true,
                                       is_string: true,
                                       default_value: nil),
          FastlaneCore::ConfigItem.new(key: :verbose,
                                       description: "verbose",
                                       optional: true,
                                       type: Boolean,
                                       default_value: false)

        ]
      end

      def self.print_params(options)
        table_title = "Params for download_json #{Fastlane::Json::VERSION}"
        FastlaneCore::PrintTable.print_values(config: options,
                                              hide_keys: [],
                                              title: table_title)
      end

      def self.return_value
        "Hash"
      end

      def self.authors
        ["Martin Gonzalez", "Thang Nguyen"]
      end

      def self.is_supported?(_platform)
        true
      end
    end
  end
end
