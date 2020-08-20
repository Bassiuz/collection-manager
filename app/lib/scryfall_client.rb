require 'net/http'
require 'json'

class ScryfallClient

  attr_accessor :card_name
  attr_reader :card_info
  
  def initialize(card_name)
    @card_name = card_name
  end

  def call
    uri = URI(url)
    response = Net::HTTP.get(uri)
    @object = JSON.parse(response, object_class: OpenStruct)
    
    turn_object_into_card_info
  end
  
  def card_name
    @card_name.gsub(" ", "+")
  end
  
  def url
    'https://api.scryfall.com/cards/named?fuzzy=' + card_name
  end

  private
  def turn_object_into_card_info
    @card_info = CardInfo.find_or_initialize_by(scryfall_id: @object.id)

    @card_info.image_url = @object.image_uris.large
    @card_info.name = @object.name
    @card_info.price = @object.prices.eur
    @card_info.save
  end
end