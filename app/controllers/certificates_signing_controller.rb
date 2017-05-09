class CertificatesSigningController < ApplicationController
  def index
    cert = "MIIEZzCCA0+gAwIBAgIQX/UeEoUFa9978uQ8FbLFyDANBgkqhkiG9w0BAQsFADBZMQswCQYDVQQGEwJHQjEXMBUGA1UEChMOQ2FiaW5ldCBPZmZpY2UxDDAKBgNVBAsTA0dEUzEjMCEGA1UEAxMaSURBUCBSZWx5aW5nIFBhcnR5IFRlc3QgQ0EwHhcNMTUwODI3MDAwMDAwWhcNMTcwODI2MjM1OTU5WjCBgzELMAkGA1UEBhMCR0IxDzANBgNVBAgTBkxvbmRvbjEPMA0GA1UEBxMGTG9uZG9uMRcwFQYDVQQKFA5DYWJpbmV0IE9mZmljZTEMMAoGA1UECxQDR0RTMSswKQYDVQQDEyJTYW1wbGUgUlAgU2lnbmluZyAoMjAxNTA4MjYxNjMzMDcpMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAuIdy6fiwdlLpMOsOiZC8DXcAU1eKDKz0w04TRAdUMR4rdv36IcyTfUortDHQ60pmX4I/s5iksey4UHCqTNZKpw6coCboyFGtGy1M6tTFhrxKc/pZmjEqV0kqgfjUnVWqiOnjpuWOJsCRfScjGfJ4Gio0omnrfX6KOTrnieaSM7aZJ7WkWUe4KRGOyxBywRIyFFbUeNgIbD/IfV7GFZCLUa9XwKjnaidTTmEhihC0TiBcnl3NCeqSwNK0TsIYSh/k5i7U/QeIvc6w34lacHOsqL5woRMPBnmS91brY/hy/vdePx7Nk8Hiwx7VpLsn5b0BVJnEZcLs5gwDid0Vra+6kQIDAQABo4H/MIH8MAwGA1UdEwEB/wQCMAAwYQYDVR0fBFowWDBWoFSgUoZQaHR0cDovL29uc2l0ZWNybC50cnVzdHdpc2UuY29tL0NhYmluZXRPZmZpY2VJREFQUmVseWluZ1BhcnR5VGVzdENBL0xhdGVzdENSTC5jcmwwDgYDVR0PAQH/BAQDAgeAMB0GA1UdDgQWBBSsYjo5j/oZAQ/h35orm1VR+n5hVTAfBgNVHSMEGDAWgBTd5PVdGgoPOtFIIh5OwPhuNvbFJTA5BggrBgEFBQcBAQQtMCswKQYIKwYBBQUHMAGGHWh0dHA6Ly9zdGQtb2NzcC50cnVzdHdpc2UuY29tMA0GCSqGSIb3DQEBCwUAA4IBAQBHYp/kWufCENWW8xI/rwVRJrOjvYxbhyEM61QoMZzTqfSQVuaBCv1qwXTMU8D+iPVtSVStFdU+vxWrU0z8ZQcd9107wZtnIJWwoJJ4WJlrmXTzBNvlqc8Q57G4Y/x9SZZdyVn4JrQRK8Vm5NzZqYZeXqgMk5xeQEObY8EQFmdryZeh/B2j0WFm3ywXOYcz77a1e1WCxBgOULPh1sQD793KjbJlEUfyeq5w/cIPovI8u4xXa78ionzq+L9t3oRh/wuTNjG/qezgArncr53sV2RZzb45RtT9+PxdQ1YFbQM7lL526kxVij0+FS6+b+EBx2CBVLWalmOugi0vA9vYpZJL"

    render json: [{issuerId: URI.unescape(params[:certificate_id]), certificate: cert, keyUse: 'SIGNING', federationEntityType: 'RP'}]
  end
end
