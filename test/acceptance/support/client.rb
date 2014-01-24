class Client

  def initialize(target_url = "http://127.0.0.1:3000")
    @target_url = target_url
  end
  attr_reader :target_url, :last_response

  def get(url)
    @last_response = HTTP.get("#{target_url}#{url}")
  end

end # class Client
