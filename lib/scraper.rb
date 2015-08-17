require 'nokogiri'
require 'pry'

class Scraper
  attr_accessor :db

  def initialize(db)
    @db = db
  end

  def scrape
    f = File.open("pokemon_index.html")
    doc = Nokogiri::HTML(f)
    f.close

    doc.css(".infocard-tall").each do |pokemon_container|
      name = pokemon_container.css(".ent-name").text
      type = pokemon_container.css(".aside").text

      Pokemon.save(name, type, @db)
    end
  end

end
