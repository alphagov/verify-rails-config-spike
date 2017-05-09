class TransactionsAssertionConsumerServiceUriController < ApplicationController
  def index
    render json: { target: 'uri' }
  end
end
