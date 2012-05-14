Then /^I should see usage information$/ do
  step %q(the output should match /tau\s+[\w\s\[\]]+#[\w \.]+/)
end

Then /^I should see commands described:$/ do |commands|
  commands.raw.each do |command|
    command = command.first
    step "the output should match /tau #{command}\\s+[\\w\\s\\[\\]]+#[\\w \\.]+/"
  end
end

Then /^I should see version$/ do
  step %q(the output should match /\d\.\d\.\d/)
end
