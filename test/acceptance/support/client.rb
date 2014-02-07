class Client

  TARGET_URL = ENV['PIPAS_TARGET_URL'] || "http://127.0.0.1:3000"

  def initialize(http = HTTP, target_url = TARGET_URL)
    @http = http
    @target_url = target_url
  end
  attr_reader :http, :target_url

### request

  def headers(headers)
    next_request[:headers] = headers
  end

  def get(url)
    # clean
    clean_response!
    # do
    next_request[:method] = :get
    next_request[:url] = "#{target_url}#{url}"
  end

### go

  def go
    @last_response ||= begin
      raise "No request" unless @next_request
      res = make_request
      clean_request!
      res
    end
  end

### response

  def last_response
    go
    @last_response
  end

  def json_body
    ::JSON.load(last_response.body)
  end

private

  def make_request
    http, nr = @http, @next_request
    http = http.with_headers(nr[:headers]) if nr[:headers]
    http.send(nr[:method], nr[:url])
  end

  def clean_request!
    @next_request = nil
  end

  def next_request
    @next_request ||= {}
  end

  def clean_response!
    @last_reponse = nil
  end

end # class Client
