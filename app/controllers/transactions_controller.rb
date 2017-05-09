class TransactionsController < ApplicationController
  def show
    @transaction = RTransaction.find_by entity_id: URI.unescape(params[:id])
    render plain: @transaction.inspect
  end
  def all
    @transactions = RTransaction.all.select("entity_id").map(&:entity_id)
    render json: @transactions
  end
  def index
    @transactions = RTransaction.all
  end
  def create
    @transaction = RTransaction.new transaction_params

    @transaction.save
    redirect_to transactions_path
  end

  def destroy
    @transaction = RTransaction.find_by entity_id: URI.unescape(params[:id])
    @transaction.destroy
  end

  private

  def transaction_params
    params.require(:transaction).permit(:entity_id, :matching_service_entity_id, :simple_id, :levels_of_assurance, :assertion_consumer_service_uri, :signing_cert, :service_homepage, :eidas_enabled)
  end

end
