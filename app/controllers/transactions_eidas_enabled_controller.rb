class TransactionsEidasEnabledController < ApplicationController
  def index
    @transaction = RTransaction.find_by entity_id: URI.unescape(params[:transaction_id])
    render json: @transaction.eidas_enabled
  end
end
