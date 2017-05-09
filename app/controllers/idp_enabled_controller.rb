class IdpEnabledController < ApplicationController
  def index
    @idp = Idp.find_by entity_id: params[:idp_id]
    render json: { enabled: @idp.enabled }
    end
end

