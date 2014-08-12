### background

Given(/^the situation is the one described in the '(.*?)' dataset$/) do |dataset|
  client.put("/testing/database?dataset=#{dataset}")
  client.go
  client.last_response.status.should eq(200)
end

### requests

Given(/^I receive a GET request to the specified location with the headers:$/) do |table|
  client.request_headers(table.hashes.first)
  loc = client.last_response['Location']
  loc.should_not be_nil
  client.get(loc)
end

Given(/^I receive a (GET|PUT|POST) request to '(.*?)'$/) do |verb,url|
  client.request(verb, url)
end

Given(/^I receive a (GET|PUT|POST) request to '(.*?)' with the headers:$/) do |verb, url, table|
  client.request_headers(table.hashes.first)
  client.request(verb, url)
end

Given(/^the request has the body:$/) do |string|
  client.request_body(string)
end

### reponse status and headers

Then(/^the response should have the headers:$/) do |table|
  table.hashes.first.each_pair do |header,expected|
    value = client.last_response[header]
    if expected =~ /^\/(.*?)\/$/
      (Regexp.compile($1) =~ value).should_not be_nil
    else
      value.to_s.should eq(expected.to_s)
    end
  end
end

Then(/^I should return a "(.*?)" response$/) do |status|
  client.last_response.status.should eq(status.to_i)
end

### reponse body

Then(/^the body should be a json object having the keys:$/) do |table|
  obj  = client.json_body
  keys = table.raw.map(&:first).sort
  obj.should be_a(Hash)
  obj.keys.sort.should eq(keys)
end

Then(/^the body should be a json array$/) do
  obj = client.json_body
  obj.should be_a(Array)
end

Then(/^all objects in this array should have the keys:$/) do |table|
  obj = client.json_body
  obj.should be_a(Array)
  keys = table.raw.map(&:first).sort
  obj.each do |elm|
    elm.should be_a(Hash)
    elm.keys.sort.should eq(keys)
  end
end

Then(/^the body should be a valid '(.*?)' resource representation$/) do |res|
  ->{
    PipasPersister::Resource[res].decode(client.json_body)
  }.should_not raise_error
end

Then(/^the '(.*?)' attribute should be a few seconds ago$/) do |attr|
  obj = client.json_body
  obj.should be_a(Hash)
  value = obj[attr]
  value.should_not be_nil
  diff = Time.now - Time.parse(value)
  diff.should(be <= 1.0)
end

Then(/^the '(.*?)' attribute should be true$/) do |attr|
  obj = client.json_body
  obj.should be_a(Hash)
  value = obj[attr]
  value.should eq(true)
end

Then(/^the '(scheduled_at|delivered_at|unavailable_at)' attribute should equal "(.*?)"$/) do |attr,date|
  obj = client.json_body
  obj.should be_a(Hash)
  value = obj[attr]
  DateTime.parse(value).should eq(DateTime.parse(date))
end

### resources

Then(/^the resource URI should have a valid example$/) do
  obj = client.json_body
  obj.each do |res|
    uri = res["uri"]["example"]
    c = client.dup
    c.get(uri)
    c.last_response.status.should eq(200)
  end
end

Then(/^the resource links should all point valid services$/) do
  obj = client.json_body
  obj.each do |res|
    res["links"].each do |link|
      uri = res["uri"]["example"]
      c = client.dup
      c.get(uri)
      c.last_response.status.should eq(200)
    end
  end
end
