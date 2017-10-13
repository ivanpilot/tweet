class JsonWebToken

  HMAC_SECRET = Rails.application.secrets.secret_key_base

  def self.encode(payload, exp_at = 24.hours.from_now)
    payload[:exp] = exp_at.to_i
    JWT.encode(payload, HMAC_SECRET, 'HS256')
  end

  def self.decode(token)
    body = JWT.decode(token, HMAC_SECRET)[0]
    HashWithIndifferentAccess.new body
  # raise custom error to be handled by custom handler
  rescue JWT::ExpiredSignature, JWT::VerificationError => e
    raise ExceptionHandler::ExpiredSignature, e.message
  end

end
