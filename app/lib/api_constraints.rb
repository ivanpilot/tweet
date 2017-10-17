class ApiConstraints

  attr_reader :version, :default

  def initialize(version, default = false)
    @version = version
    @default = default
  end

  def matches?(request)
    version = check_headers(request.headers) || default
    # binding.pry
    version
  end

  def check_headers(headers)
    accept = headers[:accept]
    accept && accept.include?("application/vnd.tweet.#{version}+json")
    # @default || req.headers['Accept'].include?("application/vnd.tweet.v#{@version}")
  end

end
