require 'fastlane/action'
require_relative '../helper/version_manager_helper'

module Fastlane
  module Actions
    class ReadVersionAction < Action
      def self.run(params)
        pubspec_file = params[:pubspec]

        begin
          pubspec = YAML.load_file(pubspec_file)
        # rubocop:disable Style/RescueStandardError
        rescue
          raise 'Failed to read pubspec.yaml'
        end

        v = SemVersion.new(pubspec['version'])

        UI.message('Version is: '.dup.concat(v.to_s))

        version_number = Helper::VersionManagerHelper.version(v)
        build_number = v.metadata

        UI.message('The version is: '.dup.concat(version_number))
        UI.message('The build number is: '.dup.concat(build_number))

        {
          'version_number' => version_number,
          'build_number' => build_number
        }
      end

      def self.description
        "Version manager"
      end

      def self.authors
        ["Ibrahim AshShohail"]
      end

      def self.return_value
        [
          ['VERSION_NUMBER', 'The version number'],
          ['BUILD_NUMBER', 'The build number'],
        ]
      end

      def self.details
        "Version manager"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(
            key: :pubspec,
            env_name: 'PUBSPEC',
            description: 'The path of pubspec.yml file',
            optional: true,
            type: String,
            default_value: './pubspec.yaml'
          ),
        ]
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end
