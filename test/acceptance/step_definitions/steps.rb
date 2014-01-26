### background

Given(/^the situation is the one described in the '(.*?)' dataset$/) do |dataset|
end

### requests

Given(/^I receive a GET request to '(.*?)'$/) do |url|
  client.get(url)
end

Given(/^I receive a GET request to '(.*?)' with the following headers:$/) do |url, table|
  client.with_headers(table.hashes.first) do
    client.get(url)
  end
end

### reponse status and headers

Then(/^the response should have the following headers:$/) do |table|
  table.hashes.first.each_pair do |header,expected|
    value = client.last_response[header]
    if expected =~ /^\/(.*?)\/$/
      value.should =~ Regexp.new($1)
    else
      value.to_s.should eq(expected.to_s)
    end
  end
end

Then(/^I should return a "(.*?)" response$/) do |status|
  client.last_response.status.should eq(status.to_i)
end

### reponse body

Then(/^the body should be a json object having the following keys:$/) do |table|
  obj  = client.json_body
  keys = table.rows.map(&:first).sort
  obj.should be_a(Hash)
  obj.keys.sort.should eq(keys)
end

Then(/^the body should be a json array$/) do
  obj = client.json_body
  obj.should be_a(Array)
end

Then(/^all objects in this array should have the following keys:$/) do |table|
  obj = client.json_body
  obj.should be_a(Array)
  keys = table.rows.map(&:first).sort
  obj.each do |elm|
    elm.should be_a(Hash)
    elm.keys.sort.should eq(keys)
  end
end
