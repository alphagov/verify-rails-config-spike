class IdpDisplayDataController < ApplicationController
  def index
    @idp = Idp.find_by entity_id: params[:idp_id]
    # render json: @idp.display_data
    render json: { simpleId: 'stub-idp-two', enabled: true, supportedLevelsOfAssurance: [ 'LEVEL_2' ], useExactComparisonType: false }
  end
end
