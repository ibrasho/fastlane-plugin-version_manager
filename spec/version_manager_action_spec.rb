describe Fastlane::Actions::VersionManagerAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The version_manager plugin is working!")

      Fastlane::Actions::VersionManagerAction.run(nil)
    end
  end
end
