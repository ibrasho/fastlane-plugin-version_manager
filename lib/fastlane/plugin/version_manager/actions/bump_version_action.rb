require 'fastlane/action'
require_relative '../helper/version_manager_helper'

module Fastlane
  module Actions
    class BumpVersionAction < Action
      def self.run(params)
        pubspec_file = params[:pubspec]

        begin
          pubspec = YAML.load_file(pubspec_file)
        # rubocop:disable Style/RescueStandardError
        rescue
          raise 'Failed to read pubspec.yaml'
        end

        oldV = SemVersion.new(pubspec['version'])
        newV = SemVersion.new(pubspec['version'])

        case params[:part]
        when "major"
          newV.major = newV.major + 1
          newV.minor = 0
          newV.patch = 0
          newV.metadata = '1'
        when "minor"
          newV.minor = newV.minor + 1
          newV.patch = 0
          newV.metadata = '1'
        when "patch"
          newV.patch = newV.patch + 1
          newV.metadata = '1'
        when "build"
          newV.metadata = (newV.metadata.to_i + 1).to_s
        else
          raise 'Invalid part'
        end

        Helper::VersionManagerHelper.write_file(
          pubspec_file,
          IO.readlines(pubspec_file).map { |s| s.gsub(oldV.to_s, newV.to_s) },
        )

        UI.message(newV)
      end

      def self.description
        "Version manager"
      end

      def self.authors
        ["Ibrahim AshShohail"]
      end

      def self.return_value
        [
          ['VERSION', 'The version number']
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
          FastlaneCore::ConfigItem.new(
            key: :part,
            env_name: 'PART',
            description: 'The version part to bump',
            optional: true,
            type: String,
            default_value: 'build'
          ),
        ]
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end
