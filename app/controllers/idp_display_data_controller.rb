class IdpDisplayDataController < ApplicationController
  def index
    @idp = Idp.find_by entity_id: params[:idp_id]
    render json: @idp.display_data
  end
end
