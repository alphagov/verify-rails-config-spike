class TransactionsController < ApplicationController
  def show
    render json: {}
  end
  def all
    # return a collection of all idp entityIds
    # @transactions = Transaction.all.select("display_data").map(&:display_data)
    # render json: @transactions
    render json: []
  end
end
