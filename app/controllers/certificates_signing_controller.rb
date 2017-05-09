class CertificatesSigningController < ApplicationController
  def index
    entity_id = URI.unescape(params[:certificate_id])
    # only handle rp certs for now
    @entity = RTransaction.find_by entity_id: entity_id

    render json: [{issuerId: entity_id, certificate: @entity.signing_cert, keyUse: 'SIGNING', federationEntityType: 'RP'}]
  end
end
