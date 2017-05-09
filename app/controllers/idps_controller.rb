class IdpsController < ApplicationController
  def index
    @idps = Idp.all
  end

  def new

  end

  def create
    @idp = Idp.new idp_params

    @idp.save
    redirect_to idps_path
  end

  def show
    @idp = Idp.find_by entity_id: params[:id]
    render plain: @idp.inspect
  end

  def all
    # return a collection of all idp entityIds
    @idps = Idp.all.select("entity_id").map(&:entity_id)
    render json: @idps
  end

  def destroy
    @idp = Idp.find_by entity_id: params[:id]
    @idp.destroy
  end

  private

  def idp_params
    params.require(:idp).permit(:entity_id, :simple_id, :display_data, :enabled)
  end
end
