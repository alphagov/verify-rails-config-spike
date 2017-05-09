class IdpsController < ApplicationController
  def index

  end

  def new

  end

  def create
    @idp = Idp.new idp_params

    @idp.save
    redirect_to @idp
  end

  def show
    @idp = Idp.find_by entity_id: params[:id]
    render plain: @idp.inspect
  end

  private

  def idp_params
    params.require(:idp).permit(:entity_id, :display_data, :enabled)
  end
end
