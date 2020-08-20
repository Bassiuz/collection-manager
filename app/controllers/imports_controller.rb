class ImportsController < ApplicationController
  # rescue_from Importer::ImporterError, with: :handle_errors

  # POST /imports
  def create
    cardnames = params[:name].select(&:present?)
    @cards = Importer::Parser.parse_cardnames_list(cardnames)
  end

  def edit
  end

  private
    def handle_errors(exception)
      redirect_to imports_url, alert: exception.message
    end
end