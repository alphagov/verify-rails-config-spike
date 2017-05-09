class TransactionsMatchingServiceEntityIdController < ApplicationController
  def index
    @transaction = RTransaction.find_by entity_id: URI.unescape(params[:transaction_id])
    render json: { simpleId: @transaction.simple_id, loaList: [ @transaction.levels_of_assurance ], serviceHomepage: @transaction.service_homepage }
  end
end
