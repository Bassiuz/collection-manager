class ImportController < ApplicationController
    before_action :set_import, only: [:index]

  # GET /import
  def create
    @result = ImportParser.parse_input(params["import_input"])

    if @result.key?(:error_code)
      @error = @result
    else
      @cards = @result[:cards]
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_import
      @import = ""
    end
end