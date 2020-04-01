class ImportController < ApplicationController
    before_action :set_import, only: [:index]

  # GET /import
  def index
  end

  # GET /import
  def create
    @cards = ImportParser.parse_input(params["import_input"])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_import
      @import = ""
    end
end