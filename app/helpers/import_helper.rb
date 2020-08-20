# frozen_string_literal: true

# ImportHelper - Returns a message where to put imported cards
module ImportHelper
  def self.generate_return_message(cards)
    if !cards.empty?
      generate_message(cards)
    else
      @message = 'Cards could not be imported.'
    end
  end

  def self.generate_message(cards)
    cards = cards.sort { |a, b| a[:box_id] <=> b[:box_id] }
    @message = ''
    @current_box = ''
    cards.each do |card|
      generate_message_for_card(card)
    end
    @message
  end

  def self.generate_message_for_card(card)
    if @current_box != card.box
      @current_box = card.box
      @message += "Add these cards to box #{card.box.name} : "
    end
    @message = @message + card.name + ' '
  end

  private_class_method :generate_message, :generate_message_for_card
end
