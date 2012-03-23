gem "minitest"
require "minitest/autorun"
$LOAD_PATH.unshift "./lib"

def fixture(filename)
  File.read("#{File.dirname(__FILE__)}/fixtures/#{filename}")
end
