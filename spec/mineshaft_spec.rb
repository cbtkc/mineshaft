require 'spec_helper'

describe Mineshaft do
  it 'create env dir' do
    options = {
      openssl_dir: "/usr/local/opt/openssl",
      version: Mineshaft::Constants::RUBY_VERSION_STABLE,
      global: false
    }
    
    env = Mineshaft::Environment.new("2.5.1", options).create
    expect(File.exist?("test")).to eq true
    expect(File.exit?("test/bin/ruby")).to eq true
    Dir.delete("test")
  end
end
