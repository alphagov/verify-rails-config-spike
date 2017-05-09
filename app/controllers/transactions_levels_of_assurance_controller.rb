class TransactionsLevelsOfAssuranceController < ApplicationController
  def index
    @transaction = RTransaction.find_by entity_id: URI.unescape(params[:transaction_id])
    render json: [ @transaction.levels_of_assurance ]
  end
end
