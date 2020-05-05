class ImportsController < ApplicationController
    before_action :set_import, only: [:index]
    rescue_from Importer::ImporterError, with: :handle_errors

  # GET /import
  def create
    @cards = Importer::Parser.parse_input(params["import_input"])
  end

  def edit
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_import
      @import = ""
    end

    def handle_errors(exception)
      redirect_to imports_url, alert: exception.message
    end
end