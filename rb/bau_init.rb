# encoding: utf-8


# ***** ENVIRONMENT EXECUTION SETUP *****
environment = parallel = test_threads = nil
environment = ENV['run_env'] if ENV.include?('run_env')
parallel = ENV['parallel'] if ENV.include?('parallel')
test_threads = ENV['test_threads'] if ENV.include?('test_threads')

require 'optparse'
options = {}
OptionParser.new do |parser|
    parser.banner = "Usage: ruby test_get_me.rb [options]"

    parser.on("--run_env [local]", String, "Required, app under test to execute against") do |value|
        environment = value.to_s.downcase
    end

    parser.on("--parallel [true]", TrueClass, "Required, run tests in parallel or not, defaults to run in parallel") do |value|
        parallel = value.to_s.downcase
    end

    parser.on("--test_threads [1]", Integer, "Required, number of tests to run in parallel") do |value|
        test_threads = value.to_s.downcase
    end

end.parse!

# known run environment values to be used as part of the cmdline arg --run_env
ENV['KNOWN_RUN_ENV'] = ['local'].join(',')

# set environment variable used by minitest to establish # of tests that can run in parallel, defaults is 2 at minitest level
test_threads = "2" if test_threads.nil?
ENV['MT_CPU'] = test_threads

# add lib and all sub dirs to loadpath
$LOAD_PATH.unshift(__dir__) unless $LOAD_PATH.include?(__dir__)
libdirs = Dir.glob("#{__dir__}/**/")
libdirs.each { |x| $LOAD_PATH.unshift(x) unless $LOAD_PATH.include?(x) }

require 'rubygems'
gem 'minitest'
require 'minitest/reporters'
require 'minitest/autorun'
#require 'minitest/tagz'
require 'rest_client'
require 'json'

# split parallel variable into parallel and random used to determine parallel and random execution
ENV['BAU_PARALLEL'], ENV['BAU_RANDOM'] = parallel.split(':')[0].to_s.strip, parallel.split(':')[1].to_s.strip unless parallel.nil?

class SerialTestCases < Minitest::Test
    def self.serialize_me!
        :random
    end
    serialize_me!
end # SerialTestCases

class ParallelTestCases < Minitest::Test
    if ENV['BAU_PARALLEL'].to_s.downcase != 'false'
      ENV['BAU_PARALLEL'] = 'true'
      parallelize_me!
    end
end # ParallelTestCases

# determine test randomness based on ENV['BAU_RANDOM'] variable, default is always run random (true)
if ENV['BAU_RANDOM'].to_s.downcase == 'false'
    Minitest::Test.i_suck_and_my_tests_are_order_dependent!
    ENV['BAU_RANDOM'] = 'false'
else
    ENV['BAU_RANDOM'] = 'true'
end

# determine app under test environment to execute against
ENV['BAU_BASE_URL'] = 'NEEDED, see bau_init.rb for more details'
unless ENV['KNOWN_RUN_ENV'].split(',').include?(environment.to_s)
    raise ArgumentError, "unknown environment: '#{environment}', known environment values: #{ENV['KNOWN_RUN_ENV'].split(',')}"
else
    ENV['BAU_RUN_ENV'] = environment.to_s.downcase
    ENV['BAU_BASE_URL'] = "http://localhost:9876"
end

# setup default test reports path used by minitest/reporters instead of 'test/reports'
reports_dir = __dir__.split(File::SEPARATOR).map { |x| x == '' ? File::SEPARATOR : x }
puts reports_dir
# reports_dir.pop
reports_dir_xml = "#{reports_dir.join('/')}/reports/#{ENV['BAU_RUN_ENV']}/xml/"
reports_dir_html = reports_dir_xml.gsub('/xml/', '/html/')
FileUtils.mkdir_p(reports_dir_xml) # create XML directory path if it does not exist
FileUtils.mkdir_p(reports_dir_html) # create HTML directory path if it does not exist
clean_folder = ENV.include?('BUILD_TAG') ? false : true
# use minitest reporters
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(:color => true),
                          Minitest::Reporters::JUnitReporter.new(reports_dir_xml, clean_folder),
                          Minitest::Reporters::HtmlReporter.new(:reports_dir => reports_dir_html, :mode => :terse)
                         ]

ENV['DEFAULT_ERR_BODY'] = "{\"code\": 405, \"description\": \"The method is not allowed for the requested URL.\", \"name\": \"Method Not Allowed\"}"
# TODO
# DEFAULT_ERR_BODY = {
#     "code": 405,
#     "description": "The method is not allowed for the requested URL.",
#     "name": "Method Not Allowed"
# }
# opts = {
#     "run_env": run_env,
#     "base_url": base_url,
#     "default_err_body": DEFAULT_ERR_BODY
# }

# print("run configuration options used:\n {0}".format(opts))

# method to output execution parameters
def print_execution_parameters
    $stderr.puts '#######################################################'
    $stderr.puts 'Execution Parameters:'
    $stderr.puts "  ENVIRONMENT         = #{ENV['BAU_RUN_ENV']}"
    $stderr.puts "  BASE URL            = #{ENV['BAU_BASE_URL']}"
    $stderr.puts "  PARALLEL / THREADS  = #{ENV['BAU_PARALLEL'].to_s.downcase == 'true' ? 'YES' : 'NO'} / #{ENV['MT_CPU']}"
    $stderr.puts "  RANDOM              = #{ENV['BAU_RANDOM'].to_s.downcase == 'true' ? 'YES' : 'NO'}"
    $stderr.puts "  TEST TAGS           = #{ENV['TAGS']}"
    $stderr.puts "  OPENSSL VER         = #{OpenSSL::OPENSSL_VERSION}"
    $stderr.puts "  OPENSSL CERT FILE   = #{OpenSSL::X509::DEFAULT_CERT_FILE}"
    $stderr.puts "  OPENSSL CERT DIR    = #{OpenSSL::X509::DEFAULT_CERT_DIR}"
    $stderr.puts "  RUBY VER            = #{RUBY_VERSION}p#{RUBY_PATCHLEVEL} (#{RUBY_RELEASE_DATE}) [#{RUBY_PLATFORM}]"
    $stderr.puts '  LOADED GEMS'
    $stderr.puts "      MINITEST VER           = #{Gem.loaded_specs['minitest'].version}"
    $stderr.puts "      MINITEST REPORTERS VER = #{Gem.loaded_specs['minitest-reporters'].version}"
    #$stderr.puts "      MINITEST TAGS VER      = #{Gem.loaded_specs['minitest-tagz'].version}"
    #$stderr.puts "      NOKOGIRI VER           = #{Gem.loaded_specs['nokogiri'].version}"
    $stderr.puts "      RESTCLIENT VER         = #{Gem.loaded_specs['rest-client'].version}"
    $stderr.puts '#######################################################'
end

# includes here for application/framework utilities
require 'base_api_utils' # bring framework base api utils file into scope
include BaseApiUtils

# output execution parameters
print_execution_parameters