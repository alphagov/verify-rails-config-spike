class TransactionsLevelsOfAssuranceController < ApplicationController
  def index
    render json: [ 'LEVEL_2' ]
  end
end
