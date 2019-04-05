# Lac: A (Ruby) Webscraping Framework!

Lac is a framework used to create and manage projects aimed at scraping data from websites.

## The Goal
The main goal of Lac is to reduce the work required to gather data form the open web. Leading for the design decisions in the future should be:

 1. Enabling users to write and manage scrapers with DRY code
 2. User workflow should resemble well known (web) frameworks (partly inspired on Ruby on Rails)
 3. Vision is also a work in progress. Will write more about this later, discussion is very much welcome!

# Getting started
In this part we'll quickly go through the steps to get started using Lac.

## Installation
Lac is a RubyGem. Make sure you have Ruby installed and run:

`$ gem install lac`


## Create project files and folders

When Lac is installed, you can use the command line tool to generate a project.

`$ lac new`

Now you will be able to enter a project name and the 

```
[Success] created directory!    ./[PROJECT_NAME]/
[Success] created directory!    ./[PROJECT_NAME]/config
[Success] created directory!    ./[PROJECT_NAME]/cache
[Success] created directory!    ./[PROJECT_NAME]/models
[Success] created directory!    ./[PROJECT_NAME]/scrapers
[Success] created directory!    ./[PROJECT_NAME]/helpers
[Success] created file!         ./[PROJECT_NAME]/Gemfile
[Success] created file!         ./[PROJECT_NAME]/config/wsfr.rb
```

Now `cd` into you project folder

`cd [PROJECT_NAME]`

You have not created any Scrapers or Models yet, so you still have an empty project. But you should be able to run the built in web interface like this:

`$ lac server`

Now visit http://localhost:4567 in your browser.

## Workflow

The goal is to collect data that fits one or more _**Models**_ you define.

One or more **_Scrapers_** will define behaviour to fetch data from the web and gather instances of defined _**Models**_ and store them.

### Defining a Model

Your models live in the `models/` folder and assume the same naming conventions as Ruby on Rails models. For example, we will define a model called `NewsItem` that represents HackerNews entries.

Create `models/news_item.rb` and enter the following code:

```
class NewsItem < WebscraperFramework::BaseModel
  
  field :title
  field :points
  field :external_identifier
  
  def primary_key
    :external_identifier
  end

  def initialize
    super
  end
  
end
```  


### Defining a Scraper

Your scrapers live in the `scrapers/` folder and also assume the same naming conventions as Ruby on Rails models. For example, we will define a model called `NewsItem` that represents HackerNews entries.

Create `models/hackernews_scraper.rb` and enter the following code:


## Upcoming Stuff

- Create a website for the project
- Create a generator for example scrapers and models
- A place for discussion: I'm going to try to build a community of people who want a say in the future of Lac.
 
