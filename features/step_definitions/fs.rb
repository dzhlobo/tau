Then /^there should be right project directory "(.*)"$/ do |project_dir|
  tau_dirs = ['/code', 'code/js', 'code/css', 'code/img'].map { |dir| "#{project_dir}/#{dir}" }
  check_directory_presence(tau_dirs, true)
  tau_files = ['tau.yml'].map { |file| "#{project_dir}/#{file}" }
  check_file_presence(tau_files, true)
end

Given /^I'm on sandbox project directory$/ do
  @dirs = [SANDBOX_PROJECT_DIR]
end
