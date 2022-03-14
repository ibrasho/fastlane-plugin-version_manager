require 'fastlane_core/ui/ui'
require 'sem_version'

module Fastlane
  UI = FastlaneCore::UI unless Fastlane.const_defined?("UI")

  module Helper
    class VersionManagerHelper
      def self.version(v)
        v.major.to_s + '.' + v.minor.to_s + '.' + v.patch.to_s
      end

      def self.write_file(file_path, content)
        File.open(file_path, "w") { |file|
          file.puts(content)
          file.close
        }
      end
    end
  end
end
