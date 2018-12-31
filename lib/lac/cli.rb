require 'colorize'
require 'readline'
require 'lac'
require 'nokogiri'
# require './application.rb'


module Lac
  class CLI

      def initialize(arguments)
        @action = arguments[0]
      end
      
      def start
        if @action == "new"
          create_project
        elsif @action == "server"
          start_server
        else
          puts "Invalid command, exiting".red.on_white.bold
          puts "The only valid command is 'new'".green.on_white.bold
        end
        exit_cli
      end

      def start_server
        Lac::Application.run!
      end

      def create_project
          puts "Hello! Welcome to Lac".bold
          puts "This is a work in progress. Check out the Git repo if you would like to contribute.".bold
          puts "Type 'exit' to quit"
          project_name = nil
          
          while project_name == nil
            input = prompt_input("Choose a name for your project: ")
            if File.directory?("./#{input}")
              puts "A folder with that name already exists, choose another name:"
            else
              project_name = input
            end
          end
           
          `mkdir #{project_name}`
          if File.directory?("./#{project_name}")
            puts "#{"[Success]".green.bold} created directory!\t ./#{project_name}/"
            
            `mkdir #{project_name}/config`
            puts "#{"[Success]".green.bold} created directory!\t ./#{project_name}/config"

            `mkdir #{project_name}/cache`
            puts "#{"[Success]".green.bold} created directory!\t ./#{project_name}/cache"

            `mkdir #{project_name}/models`
            puts "#{"[Success]".green.bold} created directory!\t ./#{project_name}/models"

            `mkdir #{project_name}/scrapers`
            puts "#{"[Success]".green.bold} created directory!\t ./#{project_name}/scrapers"

            `mkdir #{project_name}/helpers`
            puts "#{"[Success]".green.bold} created directory!\t ./#{project_name}/helpers"
          else
            puts "Something went wrong. Exiting...".red.bold
            exit_cli
          end


          File.open("./#{project_name}/Gemfile", "w") do |f|
            f.puts "source 'https://rubygems.org'"
            f.puts "gem 'lac'"
          end
          puts "#{"[Success]".green.bold} created file!\t\t ./#{project_name}/Gemfile"

          File.open("./#{project_name}/config/lac.rb", "w") do |f|
            f.puts ""
          end
          puts "#{"[Success]".green.bold} created file!\t\t ./#{project_name}/config/lac.rb"
      end

      def prompt_input(message)
          input = Readline.readline(message, true).strip
          exit_cli if input.downcase === "exit"
          return input.to_s
      end

      def exit_cli
          puts "#{"\nCya!".yellow.on_black.bold}\n"
          exit
      end
  end
end


# puts Lac::CLI.new.start