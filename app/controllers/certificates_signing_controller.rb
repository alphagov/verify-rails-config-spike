class CertificatesSigningController < ApplicationController
  def index
    render plain: params[:certificate_id]
  end
end
