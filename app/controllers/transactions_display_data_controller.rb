class TransactionsDisplayDataController < ApplicationController
  def index
    render json: { simpleId: 'test-rp', loaList: [ 'LEVEL_2' ], serviceHomepage: 'url' }
  end
end
