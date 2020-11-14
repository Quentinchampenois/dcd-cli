require "./spec_helper"

subject = Decidim::Cli::Utils::Utils

describe Decidim::Cli::Utils do
  describe "#get_ruby_version" do
    it "returns the ruby version for current app" do
      actual = subject.new("./libs/decidim-cli-utils/spec/src/")
      actual.get_ruby_version.should be_a String

      actual.get_ruby_version.should eq("2.7.1")
    end

    context "when file is inexistant" do
      it "should rescue File::NotFoundError error" do
        actual = subject.new("libs/decidim-cli-utils/spec/src/")
        actual.get_ruby_version(".inexistant-file").should match /^File seems to be inexistant/
      end
    end
  end
end
