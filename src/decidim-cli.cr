require "option_parser"
require "../libs/decidim-cli-utils/src/decidim-cli-utils"

module Decidim::Cli
  VERSION = "0.1.0"

  struct Cli
    property banner = "Welcome to Decidim Tool CLI !"

    def initialize(@argv : Array(String))
    end

    def start(&block)
      set_option_parser

      if ARGV.empty?
        puts folder_path_missing
        exit
      end

      yield
    end

    def set_option_parser
      OptionParser.parse do |parser|
        parser.banner = banner

        parser.on "-rv", "--ruby-version", "Show Decidim ruby version" do
          puts "Current ruby version :"
        end

        parser.on "-v", "--version", "Show Decidim version" do
          puts "Decidim version"
          # puts Configs.new("decidim-app/.ruby-version").get_ruby_version

        end

        parser.on "-cliv", "--cli-version", "Show CLI version" do
          puts "version 1.0"
        end

        parser.on "-h", "--help", "Show help" do
          puts parser
          exit
        end
      end
    end

    private def folder_path_missing
      "No Decidim application found, please use command as following :
          crystal run src/decidim-cli.cr [PATH_TO_DECIDIM_APP]

          or as following if your decidim app folder is 'decidim-app'
          crystal run src/decidim-cli.cr decidim-app

          or if your decidim app is the current folder :
          crystal run src/decidim-cli.cr .
          "
    end
  end

  Cli.new(ARGV).start do
    puts Decidim::Cli::Utils::Utils.new(ARGV[0]).get_ruby_version
  end
end
