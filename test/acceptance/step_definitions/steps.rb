Given(/^I make a GET request to '(.*?)'$/) do |url|
  client.get(url)
end

Given(/^I make a GET request to '(.*?)' with the following headers:$/) do |url, table|
  client.with_headers(table.hashes.first) do
    client.get(url)
  end
end

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

Then(/^I should receive a "(.*?)" response$/) do |status|
  client.last_response.status.should eq(status.to_i)
end

Then(/^the body should be a json object having the following keys:$/) do |table|
  obj  = client.json_body
  keys = table.rows.map(&:first)
  obj.should be_a(Hash)
  obj.keys.should eq(keys)
end
