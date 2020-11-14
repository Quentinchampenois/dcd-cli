require "option_parser"

module Decidim::Cli
  VERSION = "0.1.0"

  OptionParser.parse do |parser|
    parser.banner = "Welcome to Decidim Tool CLI !"

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

  if ARGV.empty?
    puts "No Decidim application found, please use command as following :
      crystal run src/decidim-cli.cr [PATH_TO_DECIDIM_APP]

      or as following if your decidim app folder is 'decidim-app'
      crystal run src/decidim-cli.cr decidim-app

      or if your decidim app is the current folder :
      crystal run src/decidim-cli.cr .
      "
    exit
  end
  puts ARGV[0]
end
