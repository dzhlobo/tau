# Copyright 2011 Solano Labs All Rights Reserved

require 'aruba/api'

class CukeGem
  @setup_done = false

  class << self
    include Aruba::Api

    attr_reader :setup_done

    def setup(gemspec, verbose = true, once=true)
      @verbose = verbose
      puts "Setup test environment for gem." if @verbose
      gem_home = setup_env
      if !@setup_done || !once then
        @setup_done = true
        mkgemdir(gem_home)
        gem_install(gemspec)
      end
    end

    def teardown
      restore_env
    end

    def setup_env
      gem_home = File.join('tmp', 'aruba-gem')
      gem_home = File.expand_path(gem_home)

      set_env('GEM_HOME', gem_home)
      set_env('GEM_PATH', gem_home)
      set_env('BUNDLE_PATH', gem_home)
      unset_bundler_env_vars

      paths = (ENV['PATH'] || "").split(File::PATH_SEPARATOR)
      paths.unshift(File.join(gem_home, 'bin'))
      set_env('PATH', paths.uniq.join(File::PATH_SEPARATOR))

      return gem_home
    end

    def mkgemdir(gem_home)
      FileUtils::rm_rf(gem_home)
      FileUtils::mkdir_p(gem_home)

      print 'Installing bundler in test environment... ' if @verbose
      output = `gem install bundler`
      if $?.exitstatus != 0 then
        raise "unable to install bundler into #{gem_home}: #{output}"
      end
      puts 'done.' if @verbose
    end

    def gem_install(gemspec)
      gem_file = nil
      begin
        pwd = Dir.pwd
        gemspec_dir = File.dirname(gemspec)
        Dir.chdir(gemspec_dir)
        print 'Building gem... ' if @verbose
        output = `gem build #{File.basename(gemspec)}`
        puts 'done.'
        Dir.chdir(pwd)

        if $?.exitstatus != 0 then
          raise "unable to build gem: #{output}"
        end

        if output =~ /File:\s+([A-Za-z0-9_.-]+[.]gem)/ then
          gem_file = $1
          print 'Installing gem... ' if @verbose
          output = `gem install #{File.join(gemspec_dir, gem_file)}`
          if $?.exitstatus != 0 then
            raise "unable to install gem: #{output}"
          end
          puts 'done.' if @verbose
        else
          raise "garbled gem build output: #{output}"
        end
      ensure
        if gem_file then
          FileUtils.rm_f(File.join(gemspec_dir, gem_file))
        end
      end
    end
  end
end
