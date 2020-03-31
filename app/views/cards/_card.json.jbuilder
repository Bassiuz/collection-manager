json.extract! card, :id, :name, :foil, :set, :box, :created_at, :updated_at
json.url card_url(card, format: :json)
