class TransactionsController < ApplicationController
  def show
    render json: {}
  end
  def all
    @transactions = Transactions.all.select("entity_id").map(&:entity_id)
    render json: @transactions
  end
  def index
    @transactions = Transactions.all
  end
  def create
    @transaction = Transaction.new transaction_params

    @transaction.save
    redirect_to @transaction
  end

  def destroy
    @transaction = Transactions.find_by entity_id: params[:id]
    @transaction.destroy
  end

  private

  def transaction_params
    params.require(:transaction).permit(:entity_id, :simple_id, :levels_of_assurance, :assertion_consumer_service_uri, :service_homepage, :eidas_enabled)
  end

end
