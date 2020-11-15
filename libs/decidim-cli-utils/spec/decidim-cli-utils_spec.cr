require "./spec_helper"

subject = Decidim::Cli::Utils::Utils.new("./libs/decidim-cli-utils/spec/src/")

describe Decidim::Cli::Utils do
  describe "#get_ruby_version" do
    it "returns the ruby version for current app" do
      subject.get_ruby_version.should be_a String

      subject.get_ruby_version.should eq("2.7.1")
    end

    context "when file is inexistant" do
      it "should rescue File::NotFoundError error" do
        subject.get_ruby_version(".inexistant-file").should match /^File seems to be inexistant/
      end
    end
  end

  describe "#get_current_branch" do
    it "returns the git current branch" do
      fail "mock git branch"
      subject.get_current_branch.should be_a String

      subject.get_current_branch.should eq("master")
    end
  end

  describe "#get_decidim_version" do
    it "returns the decidim version" do
      subject.get_decidim_version.should be_a String

      subject.get_decidim_version.should eq("0.24.0.dev")
    end
  end

  describe "#get_decidim_forge" do
    it "returns the decidim forge" do
      subject.get_decidim_version.should be_a String

      subject.get_decidim_version.should eq("0.24.0.dev")
    end
  end
end
