#!/usr/bin/env ruby

require 'rake'

module Textr
  module Rake

    # A Rake task that runs a set of specs.
    #
    # Example:
    #
    #   Spec::Rake::SpecTask.new do |t|
    #     t.warning = true
    #     t.rcov = true
    #   end
    #
    # This will create a task that can be run with:
    #
    #   rake spec
    #
    # If rake is invoked with a "SPEC=filename" command line option,
    # then the list of spec files will be overridden to include only the
    # filename specified on the command line.  This provides an easy way
    # to run just one spec.
    #
    # If rake is invoked with a "SPEC_OPTS=options" command line option,
    # then the given options will override the value of the +spec_opts+
    # attribute.
    #
    # If rake is invoked with a "RCOV_OPTS=options" command line option,
    # then the given options will override the value of the +rcov_opts+
    # attribute.
    #
    # Examples:
    #
    #   rake spec                                      # run specs normally
    #   rake spec SPEC=just_one_file.rb                # run just one spec file.
    #   rake spec SPEC_OPTS="--diff"                   # enable diffing
    #   rake spec RCOV_OPTS="--aggregate myfile.txt"   # see rcov --help for details
    #
    # Each attribute of this task may be a proc. This allows for lazy evaluation,
    # which is sometimes handy if you want to defer the evaluation of an attribute value
    # until the task is run (as opposed to when it is defined).
    #
    # This task can also be used to run existing Test::Unit tests and get RSpec
    # output, for example like this:
    #
    #   require 'spec/rake/spectask'
    #   Spec::Rake::SpecTask.new do |t|
    #     t.ruby_opts = ['-rtest/unit']
    #     t.spec_files = FileList['test/**/*_test.rb']
    #   end
    #
    class TextrTask < ::Rake::TaskLib
      
      def self.attr_accessor(*names)
        super(*names)
        names.each do |name|
          module_eval "def #{name}() evaluate(@#{name}) end" # Allows use of procs
        end
      end
      
    end
  end
end