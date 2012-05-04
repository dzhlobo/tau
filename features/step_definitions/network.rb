require 'net/http'
require 'uri'
require 'haml'
require 'sass'
require 'coffee-script'

When /^I go in browser to "(.*)"$/ do |url|
  @response = Net::HTTP.get_response(URI url).body
end

Then /^I should see:$/ do |string|
  @response.should == string
end

# TODO: move it in more appropriate place
def render(content, lang)
  return Haml::Engine.new(content).render if lang == 'haml'
  return Sass::Engine.new(content).render if lang == 'sass'
  return Sass::Engine.new(content, syntax: :scss).render if lang == 'scss'
  return CoffeeScript.compile(content) if lang == 'coffee-script'
end

Then /^I should see (html|css|js) compiled from (haml|sass|scss|coffee-script) in "(.*)"$/ do |type, lang, filename|
  file_content = nil
  in_current_dir do
    file_content = File.read(filename)
  end
  @response.should == render(file_content, lang)
end
