# DO NOT MODIFY THIS FILE
# Generated by Bundler 0.9.25

require 'digest/sha1'
require 'yaml'
require 'pathname'
require 'rubygems'
Gem.source_index # ensure Rubygems is fully loaded in Ruby 1.9

module Gem
  class Dependency
    if !instance_methods.map { |m| m.to_s }.include?("requirement")
      def requirement
        version_requirements
      end
    end
  end
end

module Bundler
  class Specification < Gem::Specification
    attr_accessor :relative_loaded_from

    def self.from_gemspec(gemspec)
      spec = allocate
      gemspec.instance_variables.each do |ivar|
        spec.instance_variable_set(ivar, gemspec.instance_variable_get(ivar))
      end
      spec
    end

    def loaded_from
      return super unless relative_loaded_from
      source.path.join(relative_loaded_from).to_s
    end

    def full_gem_path
      Pathname.new(loaded_from).dirname.expand_path.to_s
    end
  end

  module SharedHelpers
    attr_accessor :gem_loaded

    def default_gemfile
      gemfile = find_gemfile
      gemfile or raise GemfileNotFound, "Could not locate Gemfile"
      Pathname.new(gemfile)
    end

    def in_bundle?
      find_gemfile
    end

    def env_file
      default_gemfile.dirname.join(".bundle/environment.rb")
    end

  private

    def find_gemfile
      return ENV['BUNDLE_GEMFILE'] if ENV['BUNDLE_GEMFILE']

      previous = nil
      current  = File.expand_path(Dir.pwd)

      until !File.directory?(current) || current == previous
        filename = File.join(current, 'Gemfile')
        return filename if File.file?(filename)
        current, previous = File.expand_path("..", current), current
      end
    end

    def clean_load_path
      # handle 1.9 where system gems are always on the load path
      if defined?(::Gem)
        me = File.expand_path("../../", __FILE__)
        $LOAD_PATH.reject! do |p|
          next if File.expand_path(p).include?(me)
          p != File.dirname(__FILE__) &&
            Gem.path.any? { |gp| p.include?(gp) }
        end
        $LOAD_PATH.uniq!
      end
    end

    def reverse_rubygems_kernel_mixin
      # Disable rubygems' gem activation system
      ::Kernel.class_eval do
        if private_method_defined?(:gem_original_require)
          alias rubygems_require require
          alias require gem_original_require
        end

        undef gem
      end
    end

    def cripple_rubygems(specs)
      reverse_rubygems_kernel_mixin

      executables = specs.map { |s| s.executables }.flatten
      Gem.source_index # ensure RubyGems is fully loaded

     ::Kernel.class_eval do
        private
        def gem(*) ; end
      end

      ::Kernel.send(:define_method, :gem) do |dep, *reqs|
        if executables.include? File.basename(caller.first.split(':').first)
          return
        end
        opts = reqs.last.is_a?(Hash) ? reqs.pop : {}

        unless dep.respond_to?(:name) && dep.respond_to?(:requirement)
          dep = Gem::Dependency.new(dep, reqs)
        end

        spec = specs.find  { |s| s.name == dep.name }

        if spec.nil?
          e = Gem::LoadError.new "#{dep.name} is not part of the bundle. Add it to Gemfile."
          e.name = dep.name
          e.version_requirement = dep.requirement
          raise e
        elsif dep !~ spec
          e = Gem::LoadError.new "can't activate #{dep}, already activated #{spec.full_name}. " \
                                 "Make sure all dependencies are added to Gemfile."
          e.name = dep.name
          e.version_requirement = dep.requirement
          raise e
        end

        true
      end

      # === Following hacks are to improve on the generated bin wrappers ===

      # Yeah, talk about a hack
      source_index_class = (class << Gem::SourceIndex ; self ; end)
      source_index_class.send(:define_method, :from_gems_in) do |*args|
        source_index = Gem::SourceIndex.new
        source_index.spec_dirs = *args
        source_index.add_specs(*specs)
        source_index
      end

      # OMG more hacks
      gem_class = (class << Gem ; self ; end)
      gem_class.send(:define_method, :bin_path) do |name, *args|
        exec_name, *reqs = args

        spec = nil

        if exec_name
          spec = specs.find { |s| s.executables.include?(exec_name) }
          spec or raise Gem::Exception, "can't find executable #{exec_name}"
        else
          spec = specs.find  { |s| s.name == name }
          exec_name = spec.default_executable or raise Gem::Exception, "no default executable for #{spec.full_name}"
        end

        gem_bin = File.join(spec.full_gem_path, spec.bindir, exec_name)
        gem_from_path_bin = File.join(File.dirname(spec.loaded_from), spec.bindir, exec_name)
        File.exist?(gem_bin) ? gem_bin : gem_from_path_bin
      end
    end

    extend self
  end
end

module Bundler
  ENV_LOADED   = true
  LOCKED_BY    = '0.9.25'
  FINGERPRINT  = "80aeb9018e8878a37b2e92e4d57dd04d358cc7d0"
  HOME         = '/Users/ryandotsmith/.bundle/ruby/1.8/bundler'
  AUTOREQUIRES = {:test=>[["factory_girl", false], ["rspec", false], ["rspec-rails", false]], :default=>[["authlogic", false], ["facets/dictionary", true], ["formtastic", false], ["friendly_id", false], ["haml", false], ["pg", false], ["rails", false], ["ruby-debug", false], ["sanitize", false], ["sqlite3", true], ["subdomain_routes", false]], :cucumber=>[["cucumber-rails", false], ["database_cleaner", false], ["webrat", false]]}
  SPECS        = [
        {:load_paths=>["/Users/ryandotsmith/.bundle/ruby/1.8/gems/rake-0.8.7/lib"], :loaded_from=>"/Users/ryandotsmith/.bundle/ruby/1.8/specifications/rake-0.8.7.gemspec", :name=>"rake"},
        {:load_paths=>["/Library/Ruby/Gems/1.8/gems/activesupport-2.3.5/lib"], :loaded_from=>"/Library/Ruby/Gems/1.8/specifications/activesupport-2.3.5.gemspec", :name=>"activesupport"},
        {:load_paths=>["/Library/Ruby/Gems/1.8/gems/rack-1.0.1/lib"], :loaded_from=>"/Library/Ruby/Gems/1.8/specifications/rack-1.0.1.gemspec", :name=>"rack"},
        {:load_paths=>["/Library/Ruby/Gems/1.8/gems/actionpack-2.3.5/lib"], :loaded_from=>"/Library/Ruby/Gems/1.8/specifications/actionpack-2.3.5.gemspec", :name=>"actionpack"},
        {:load_paths=>["/Library/Ruby/Gems/1.8/gems/actionmailer-2.3.5/lib"], :loaded_from=>"/Library/Ruby/Gems/1.8/specifications/actionmailer-2.3.5.gemspec", :name=>"actionmailer"},
        {:load_paths=>["/Library/Ruby/Gems/1.8/gems/activerecord-2.3.5/lib"], :loaded_from=>"/Library/Ruby/Gems/1.8/specifications/activerecord-2.3.5.gemspec", :name=>"activerecord"},
        {:load_paths=>["/Library/Ruby/Gems/1.8/gems/activeresource-2.3.5/lib"], :loaded_from=>"/Library/Ruby/Gems/1.8/specifications/activeresource-2.3.5.gemspec", :name=>"activeresource"},
        {:load_paths=>["/Library/Ruby/Gems/1.8/gems/authlogic-2.1.3/lib"], :loaded_from=>"/Library/Ruby/Gems/1.8/specifications/authlogic-2.1.3.gemspec", :name=>"authlogic"},
        {:load_paths=>["/Library/Ruby/Gems/1.8/gems/builder-2.1.2/lib"], :loaded_from=>"/Library/Ruby/Gems/1.8/specifications/builder-2.1.2.gemspec", :name=>"builder"},
        {:load_paths=>["/Library/Ruby/Gems/1.8/gems/columnize-0.3.1/lib"], :loaded_from=>"/Library/Ruby/Gems/1.8/specifications/columnize-0.3.1.gemspec", :name=>"columnize"},
        {:load_paths=>["/Library/Ruby/Gems/1.8/gems/diff-lcs-1.1.2/lib"], :loaded_from=>"/Library/Ruby/Gems/1.8/specifications/diff-lcs-1.1.2.gemspec", :name=>"diff-lcs"},
        {:load_paths=>["/Users/ryandotsmith/.bundle/ruby/1.8/gems/trollop-1.16.2/lib"], :loaded_from=>"/Users/ryandotsmith/.bundle/ruby/1.8/specifications/trollop-1.16.2.gemspec", :name=>"trollop"},
        {:load_paths=>["/Users/ryandotsmith/.bundle/ruby/1.8/gems/gherkin-1.0.30/lib"], :loaded_from=>"/Users/ryandotsmith/.bundle/ruby/1.8/specifications/gherkin-1.0.30.gemspec", :name=>"gherkin"},
        {:load_paths=>["/Users/ryandotsmith/.bundle/ruby/1.8/gems/json_pure-1.4.3/lib"], :loaded_from=>"/Users/ryandotsmith/.bundle/ruby/1.8/specifications/json_pure-1.4.3.gemspec", :name=>"json_pure"},
        {:load_paths=>["/Library/Ruby/Gems/1.8/gems/term-ansicolor-1.0.5/lib"], :loaded_from=>"/Library/Ruby/Gems/1.8/specifications/term-ansicolor-1.0.5.gemspec", :name=>"term-ansicolor"},
        {:load_paths=>["/Users/ryandotsmith/.bundle/ruby/1.8/gems/cucumber-0.7.3/lib"], :loaded_from=>"/Users/ryandotsmith/.bundle/ruby/1.8/specifications/cucumber-0.7.3.gemspec", :name=>"cucumber"},
        {:load_paths=>["/Library/Ruby/Gems/1.8/gems/cucumber-rails-0.3.0/lib"], :loaded_from=>"/Library/Ruby/Gems/1.8/specifications/cucumber-rails-0.3.0.gemspec", :name=>"cucumber-rails"},
        {:load_paths=>["/Library/Ruby/Gems/1.8/gems/database_cleaner-0.5.0/lib"], :loaded_from=>"/Library/Ruby/Gems/1.8/specifications/database_cleaner-0.5.0.gemspec", :name=>"database_cleaner"},
        {:load_paths=>["/Library/Ruby/Gems/1.8/gems/facets-2.5.0/lib/core", "/Library/Ruby/Gems/1.8/gems/facets-2.5.0/lib/lore", "/Library/Ruby/Gems/1.8/gems/facets-2.5.0/lib/more"], :loaded_from=>"/Library/Ruby/Gems/1.8/specifications/facets-2.5.0.gemspec", :name=>"facets"},
        {:load_paths=>["/Users/ryandotsmith/.bundle/ruby/1.8/gems/factory_girl-1.2.4/lib"], :loaded_from=>"/Users/ryandotsmith/.bundle/ruby/1.8/specifications/factory_girl-1.2.4.gemspec", :name=>"factory_girl"},
        {:load_paths=>["/Library/Ruby/Gems/1.8/gems/formtastic-0.9.8/lib"], :loaded_from=>"/Library/Ruby/Gems/1.8/specifications/formtastic-0.9.8.gemspec", :name=>"formtastic"},
        {:load_paths=>["/Users/ryandotsmith/.bundle/ruby/1.8/gems/friendly_id-3.0.4/lib"], :loaded_from=>"/Users/ryandotsmith/.bundle/ruby/1.8/specifications/friendly_id-3.0.4.gemspec", :name=>"friendly_id"},
        {:load_paths=>["/Users/ryandotsmith/.bundle/ruby/1.8/gems/haml-3.0.4/lib"], :loaded_from=>"/Users/ryandotsmith/.bundle/ruby/1.8/specifications/haml-3.0.4.gemspec", :name=>"haml"},
        {:load_paths=>["/Library/Ruby/Gems/1.8/gems/linecache-0.43/lib"], :loaded_from=>"/Library/Ruby/Gems/1.8/specifications/linecache-0.43.gemspec", :name=>"linecache"},
        {:load_paths=>["/Library/Ruby/Gems/1.8/gems/nokogiri-1.4.1/lib", "/Library/Ruby/Gems/1.8/gems/nokogiri-1.4.1/ext"], :loaded_from=>"/Library/Ruby/Gems/1.8/specifications/nokogiri-1.4.1.gemspec", :name=>"nokogiri"},
        {:load_paths=>["/Users/ryandotsmith/.bundle/ruby/1.8/gems/pg-0.9.0/lib", "/Users/ryandotsmith/.bundle/ruby/1.8/gems/pg-0.9.0/ext"], :loaded_from=>"/Users/ryandotsmith/.bundle/ruby/1.8/specifications/pg-0.9.0.gemspec", :name=>"pg"},
        {:load_paths=>["/Library/Ruby/Gems/1.8/gems/rack-test-0.5.3/lib"], :loaded_from=>"/Library/Ruby/Gems/1.8/specifications/rack-test-0.5.3.gemspec", :name=>"rack-test"},
        {:load_paths=>["/Library/Ruby/Gems/1.8/gems/rails-2.3.5/lib"], :loaded_from=>"/Library/Ruby/Gems/1.8/specifications/rails-2.3.5.gemspec", :name=>"rails"},
        {:load_paths=>["/Library/Ruby/Gems/1.8/gems/rspec-1.3.0/lib"], :loaded_from=>"/Library/Ruby/Gems/1.8/specifications/rspec-1.3.0.gemspec", :name=>"rspec"},
        {:load_paths=>["/Library/Ruby/Gems/1.8/gems/rspec-rails-1.3.2/lib"], :loaded_from=>"/Library/Ruby/Gems/1.8/specifications/rspec-rails-1.3.2.gemspec", :name=>"rspec-rails"},
        {:load_paths=>["/Library/Ruby/Gems/1.8/gems/ruby-debug-base-0.10.3/lib"], :loaded_from=>"/Library/Ruby/Gems/1.8/specifications/ruby-debug-base-0.10.3.gemspec", :name=>"ruby-debug-base"},
        {:load_paths=>["/Library/Ruby/Gems/1.8/gems/ruby-debug-0.10.3/cli"], :loaded_from=>"/Library/Ruby/Gems/1.8/specifications/ruby-debug-0.10.3.gemspec", :name=>"ruby-debug"},
        {:load_paths=>["/Users/ryandotsmith/.bundle/ruby/1.8/gems/sanitize-1.2.1/lib"], :loaded_from=>"/Users/ryandotsmith/.bundle/ruby/1.8/specifications/sanitize-1.2.1.gemspec", :name=>"sanitize"},
        {:load_paths=>["/Users/ryandotsmith/.bundle/ruby/1.8/gems/sqlite3-ruby-1.2.5/lib", "/Users/ryandotsmith/.bundle/ruby/1.8/gems/sqlite3-ruby-1.2.5/ext"], :loaded_from=>"/Users/ryandotsmith/.bundle/ruby/1.8/specifications/sqlite3-ruby-1.2.5.gemspec", :name=>"sqlite3-ruby"},
        {:load_paths=>["/Library/Ruby/Gems/1.8/gems/subdomain_routes-0.3.1/lib"], :loaded_from=>"/Library/Ruby/Gems/1.8/specifications/subdomain_routes-0.3.1.gemspec", :name=>"subdomain_routes"},
        {:load_paths=>["/Library/Ruby/Gems/1.8/gems/webrat-0.7.0/lib"], :loaded_from=>"/Library/Ruby/Gems/1.8/specifications/webrat-0.7.0.gemspec", :name=>"webrat"},
      ].map do |hash|
    if hash[:virtual_spec]
      spec = eval(hash[:virtual_spec], TOPLEVEL_BINDING, "<virtual spec for '#{hash[:name]}'>")
    else
      dir = File.dirname(hash[:loaded_from])
      spec = Dir.chdir(dir){ eval(File.read(hash[:loaded_from]), TOPLEVEL_BINDING, hash[:loaded_from]) }
    end
    spec.loaded_from = hash[:loaded_from]
    spec.require_paths = hash[:load_paths]
    if spec.loaded_from.include?(HOME)
      Bundler::Specification.from_gemspec(spec)
    else
      spec
    end
  end

  extend SharedHelpers

  def self.configure_gem_path_and_home(specs)
    # Fix paths, so that Gem.source_index and such will work
    paths = specs.map{|s| s.installation_path }
    paths.flatten!; paths.compact!; paths.uniq!; paths.reject!{|p| p.empty? }
    ENV['GEM_PATH'] = paths.join(File::PATH_SEPARATOR)
    ENV['GEM_HOME'] = paths.first
    Gem.clear_paths
  end

  def self.match_fingerprint
    lockfile = File.expand_path('../../Gemfile.lock', __FILE__)
    lock_print = YAML.load(File.read(lockfile))["hash"] if File.exist?(lockfile)
    gem_print = Digest::SHA1.hexdigest(File.read(File.expand_path('../../Gemfile', __FILE__)))

    unless gem_print == lock_print
      abort 'Gemfile changed since you last locked. Please run `bundle lock` to relock.'
    end

    unless gem_print == FINGERPRINT
      abort 'Your bundled environment is out of date. Run `bundle install` to regenerate it.'
    end
  end

  def self.setup(*groups)
    match_fingerprint
    clean_load_path
    cripple_rubygems(SPECS)
    configure_gem_path_and_home(SPECS)
    SPECS.each do |spec|
      Gem.loaded_specs[spec.name] = spec
      spec.require_paths.each do |path|
        $LOAD_PATH.unshift(path) unless $LOAD_PATH.include?(path)
      end
    end
    self
  end

  def self.require(*groups)
    groups = [:default] if groups.empty?
    groups.each do |group|
      (AUTOREQUIRES[group.to_sym] || []).each do |file, explicit|
        if explicit
          Kernel.require file
        else
          begin
            Kernel.require file
          rescue LoadError
          end
        end
      end
    end
  end

  # Set up load paths unless this file is being loaded after the Bundler gem
  setup unless defined?(Bundler::GEM_LOADED)
end
