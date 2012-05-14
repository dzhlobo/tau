Then /^there should be right project directory "(.*)"$/ do |project_dir|
  tau_dirs = ['/code', 'code/js', 'code/css', 'code/img'].map { |dir| "#{project_dir}/#{dir}" }
  check_directory_presence(tau_dirs, true)
  tau_files = ['tau.yml'].map { |file| "#{project_dir}/#{file}" }
  check_file_presence(tau_files, true)
end

Then /^I should see file "(.*)" compiled from (haml|sass|scss|coffee-script) in "(.*)"$/ do |compiled_file, lang, src_file|
  compiled_file_content = nil
  src_file_content = nil
  in_current_dir do
    compiled_file_content = File.read compiled_file
    src_file_content = File.read src_file
  end
  compiled_file_content.should == render(src_file_content, lang)
end

Given /^I'm on sandbox project directory$/ do
  @dirs = [SANDBOX_PROJECT_DIR]
end
