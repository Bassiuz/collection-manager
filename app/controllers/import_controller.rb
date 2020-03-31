class ImportController < ApplicationController
    before_action :set_import, only: [:index]

  # GET /import
  def index
  end

  # GET /import
  def create
    @cards = helpers.parse_input(params["import_input"])

    if @cards.length > 0
        @message = ""
        for card in @cards
            if @message.length > 0
                @message = @message+ ", "
            end
            @message = @message + card.name
        end
        @message = @message + " added!"
    else
        @message = "Cards could not be imported."
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_import
      @import = ""
    end
end