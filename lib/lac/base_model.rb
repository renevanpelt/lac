require 'yaml'
module Lac

  class BaseModel
    
    # Any suggestions on how to manage these fields 
    # better are welcome!
    
    @@fields = []
    
    def initialize
    end

    def validates?
      return true unless primary_key
      self.method(primary_key).call.present?
    end

    def self.field(symbol)

      @@fields.push(symbol)
      @@fields = @@fields.uniq
      attr_accessor symbol
    end
   
    def to_hash
      hash = {}
      @@fields.each do |field|
        if field
          hash[field] = self.method(field).call
        end
      end
      hash
    end
    
    def self.fields
      self.new.fields
    end
    
    def self.primary_key
      self.new.primary_key
    end

    def self.all
      begin
        YAML::load_file("#{self.name}.yml")
        YAML::load_file("#{self.name}.yml")[:collecion]
        YAML::load_file("#{self.name}.yml")[:collection]
      rescue
        []
      end
    end

    def fields
      @@fields
    end

    def save
      filename = "#{self.class}.yml"
      FileUtils.touch(filename)
      if validates? && id
        collection = YAML::load_file(filename)
        collection = {} unless collection
        collection[:collection] = {} unless collection[:collection]
        collection[:collection][id.to_sym] = to_hash
        File.open(filename, 'w') {|f| f.write collection.to_yaml }
      end
    end

    def id
      if self.validates?
        Digest::SHA256.hexdigest(self.method(self.primary_key).call)
      end
    end

  end
end