class CalculateHubSignature
  def initialize
    @secret = ENV.fetch('GH_SECRET', '')
  end

  def call(body)
    OpenSSL::HMAC.hexdigest('sha1', @secret, body)
  end
end
