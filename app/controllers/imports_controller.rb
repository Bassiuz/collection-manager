class ImportsController < ApplicationController
    before_action :set_import, only: [:index]
    rescue_from Importer::ImporterError, with: :handle_errors

  # GET /import
  def create
    cardnames = []

    keys = params.keys.select { |key| key.to_s.match(/^text_field\d+/) }
    keys.each do |key|
      cardnames << params[key] unless params[key].blank?
    end

    @cards = Importer::Parser.parse_cardnames_list(cardnames)
  end

  def edit
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_import
      @import = ""
      @labels = []
      label_count = 15
      (0..label_count).each do |i|
        @labels << {id: i , name: "text_field" + i.to_s}
      end
    end

    def handle_errors(exception)
      redirect_to imports_url, alert: exception.message
    end
end