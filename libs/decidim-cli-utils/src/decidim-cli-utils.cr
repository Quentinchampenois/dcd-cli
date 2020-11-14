module Decidim::Cli::Utils
  VERSION = "0.1.0"

  struct Utils
    def initialize(@base_path : String)
    end

    def get_ruby_version(filename : String = ".ruby-version")
      lines = read_specific_file(filename)

      return "Undefined ruby version" if lines.nil?

      lines[0]
    end

    def get_decidim_version(filename : String = "Gemfile.lock")
      lines = read_specific_file(filename)

      return "There is an issue with the Gemfile.lock file" if lines.nil?

      decidim_version = "Decidim version not found in Gemfile.lock"

      lines.each do |line|
        if /decidim \((?!=).+/i =~ line
          idx = line.strip.chars.index('(')

          decidim_version = line.strip[idx+1..line.strip.size-2] unless idx.nil?
        end
      end

      decidim_version
    end

    def get_current_branch
      add_slash_to_base_path unless valid_folder_format?
      return "Not a git repository" unless Dir.exists?("#{@base_path}.git")

      %x(cd #{@base_path} && git branch --show-current).chomp
    end

    private def read_specific_file(filename : String)
      return if filename.blank?

      add_slash_to_base_path unless valid_folder_format?

      begin
        File.read_lines("#{@base_path}#{filename}")
      rescue err : File::NotFoundError
        ["File seems to be inexistant: #{err.message}"]
      end
    end

    private def valid_folder_format?
      @base_path[@base_path.size - 1] == '/'
    end

    private def add_slash_to_base_path
      @base_path = "#{@base_path}/"
    end
  end
end
