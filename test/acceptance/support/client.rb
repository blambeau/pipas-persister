class Client

  TARGET_URL = ENV['PIPAS_TARGET_URL'] || "http://127.0.0.1:3000"

  def initialize(http = HTTP, target_url = TARGET_URL)
    @http = http
    @target_url = target_url
  end
  attr_reader :http, :target_url

### request

  def request_headers(headers)
    next_request[:headers] = headers
  end

  def request_body(body)
    next_request[:body] = body
  end

  def request(verb, url)
    # clean
    clean_response!
    # do
    next_request[:method] = verb.downcase.to_sym
    next_request[:url] = "#{target_url}#{url}"
  end

  def get(url)
    request(:get, url)
  end

  def put(url)
    request(:put, url)
  end

  def post(url)
    request(:post, url)
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
    # http instance
    http, nr = @http, @next_request
    http = http.with_headers(nr[:headers]) if nr[:headers]
    # options
    opts = {}
    opts[:body] = nr[:body] if nr[:body]
    # make call
    http.send(nr[:method], nr[:url], opts)
  end

  def clean_request!
    @next_request = nil
  end

  def next_request
    @next_request ||= {}
  end

  def clean_response!
    @last_response = nil
  end

end # class Client
