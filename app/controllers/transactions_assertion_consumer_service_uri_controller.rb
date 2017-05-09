class TransactionsAssertionConsumerServiceUriController < ApplicationController
  def index
    @transaction = RTransaction.find_by entity_id: URI.unescape(params[:transaction_id])
    render json: { target: @transaction.assertion_consumer_service_uri }
  end
end
