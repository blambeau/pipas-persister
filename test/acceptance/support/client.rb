class Client

  TARGET_URL = ENV['PIPAS_TARGET_URL'] || "http://127.0.0.1:3000"

  def initialize(http = HTTP, target_url = TARGET_URL)
    @http = http
    @target_url = target_url
  end
  attr_reader :http, :target_url, :last_response

  def with_headers(headers)
    old_http, @http = http, http.with_headers(headers)
    yield
    @http = old_http
  end

  def get(url)
    @last_response = http.get("#{target_url}#{url}")
  end

  def json_body
    ::JSON.load(@last_response.body)
  end

end # class Client
