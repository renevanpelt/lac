require 'yaml'
require 'haml'

require 'active_support/all'

require 'open-uri'
require 'uri'
require 'csv'

require 'lac'
require 'sinatra'
require "sinatra/base"

module Lac
  class Application < Sinatra::Base

    def render_file(file, params= {})
      gemdir = Gem.loaded_specs["lac"].gem_dir
      base_template = File.read(gemdir + "/views/base.html.haml")
      content = Haml::Engine.new(File.read(gemdir + "/views/#{file}.html.haml")).render(Object.new, models: @@models, scrapers: @@scrapers, **params)
      return Haml::Engine.new(base_template).render(Object.new, content: content, models: @@models, scrapers: @@scrapers)
    end

    model_files =  Dir["./models/*"]
    helper_files =  Dir["./helpers/*"]
    scraper_files =  Dir["./scrapers/*"]

    data = {}

    @@scrapers = []
    @@models = []

    model_files.each do |filename|
      require filename
      puts filename
      @@models << Object.const_get(filename.split("/").last.split(".").first.camelize)
      puts Object.const_get(filename.split("/").last.split(".").first.camelize)
    end

    helper_files.each do |filename|
      require filename
      puts filename
    end

    scraper_files.each do |filename|
      require filename
      puts filename
      @@scrapers << Object.const_get(filename.split("/").last.split(".").first.camelize)
      Object.const_get(filename.split("/").last.split(".").first.camelize).data
    end




    ## System routes

    get '/' do
      render_file("home")
    end

    get '/models' do
      render_file("models")
    end

    get '/scrapers' do
      render_file("scrapers")
    end

    get '/scrapers/:name/scrape' do
      scraper = @@scrapers.select { |scraper| params[:name] == scraper.name.underscore }.first
      scraper.data
      render_file("scrapers")
    end


    get '/models/:name/csv' do

      content_type 'application/csv'
      attachment "myfilename.csv"
      m = @@models.select { |model| params[:name] == model.name.underscore }.first
      csv_string = CSV.generate(col_sep: ";") do |csv|
          header_row = ["id"] + m.fields
          m.all.each do |id, obj|
            csv << [id] + m.fields.map {|a| obj[a]}
          end
      end    
      # render_file("", { })
    end

    get '/models/:name' do
      render_file("model", {model: @@models.select { |model| params[:name] == model.name.underscore }.first })
    end


    puts "Loaded Models #{@@models}"

  end
end