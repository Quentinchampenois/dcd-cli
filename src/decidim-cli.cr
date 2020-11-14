require "option_parser"
require "../libs/decidim-cli-utils/src/decidim-cli-utils"

module Decidim::Cli
  VERSION = "0.1.0"

  struct Cli
    property banner = "Welcome to Decidim Tool CLI !"
    property decidim_app_path

    def initialize(@decidim_app_path : String = "")
    end

    def start(&block)
      set_option_parser

      yield
    end

    def set_option_parser
      OptionParser.parse do |parser|
        parser.banner = banner

        parser.on "-cliv", "--cli-version", "Show CLI version" do
          puts "version #{Decidim::Cli::VERSION}"
        end

        parser.on "-h", "--help", "Show help" do
          puts parser
          exit
        end
      end
    end

    def folder_path_missing
      "No Decidim application found, please use command as following :
          crystal run src/decidim-cli.cr [PATH_TO_DECIDIM_APP]

          or as following if your decidim app folder is 'decidim-app'
          crystal run src/decidim-cli.cr decidim-app

          or if your decidim app is the current folder :
          crystal run src/decidim-cli.cr .
          "
    end
  end

  CLI_APP = Cli.new

  CLI_APP.start do
    if ARGV.empty?
      puts CLI_APP.folder_path_missing

      exit
    end

    CLI_APP.decidim_app_path = ARGV[0]

    cli_utils = Decidim::Cli::Utils::Utils.new(CLI_APP.decidim_app_path)

    configs = {
      :current_git_branch => "",
      :ruby_version => "",
      :decidim_version => "",
      :decidim_forge => "",
      :decidim_branch => "",
    }

    configs[:ruby_version] = cli_utils.get_ruby_version

    puts configs
  end
end
