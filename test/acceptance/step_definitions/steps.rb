Given(/^I make a GET request to '(.*?)'$/) do |url|
  client.get(url)
end

Then(/^I should observe a "(.*?)" response$/) do |status|
  client.last_response.status.should eq(status.to_i)
end
