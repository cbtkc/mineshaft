# mineshaft
#
# author:: Cameron Testerman
# email:: cameronbtesterman@gmail.com
# created:: 2017-04-14 1:19PM
#
# Copyright (c) 2017-2025 Cameron Testerman

require 'fileutils'
require 'net/http'
require 'rubygems/package'
require 'zlib'
require 'mineshaft/shell'

module Mineshaft
  class Installer
    attr_accessor :url, :directory, :version, :options, :global

    include Mineshaft::Shell

    def initialize
      @ruby_archive = "ruby.tar.gz"
      yield self
    end

    def run
      download @url, @directory
      unzip          @directory
      build          @directory
    end

    private

    def find_slash_indices(url)
      slash_array = []
      url = url.split("")
      i = 0

      url.each do |l|
        break if slash_array.length == 3
        slash_array.push(i) if l == "/"
        i += 1
      end

      @slash_array = slash_array
    end

    def split_url(url)
      find_slash_indices(url)
      beg = @slash_array[1] + 1
      fin = @slash_array[2] - 1
      site = url[beg..fin]
      fin += 1
      tar = url[fin..url.length]

      yield site, tar
    end

    def download(url, download_dir)
      puts "Downloading #{url}"
      split_url(url) do |site, file|
        Net::HTTP.start(site) do |http|
          response = http.get(file)
          open("#{download_dir}/#@ruby_archive", "w") do |f|
            f.write(response.body)
          end
        end
      end
    end

    def unzip(dir)
      FileUtils::mkdir_p("#{dir}/ruby-#@version")
      tar_extract = Gem::Package::TarReader.new(Zlib::GzipReader.open("#{dir}/#@ruby_archive"))
      tar_extract.rewind
      puts "Unzipping archive"
      tar_extract.each do |entry|
        if entry.full_name.split('').last == '/'
          puts "extracted dir: #{dir}/#{entry.full_name}"
          FileUtils::mkdir_p("#{dir}/#{entry.full_name}")
        elsif entry.file?
          puts "extracted file: #{dir}/#{entry.full_name}"
          File.open("#{dir}/#{entry.full_name}", 'w') {|file| file.write(entry.read)}
        end
      end
      puts "Archive successfully unzipped"
      tar_extract.close
    end

    def configure_options(prefix)
      config = @global ? "./configure --prefix #{@directory}" : "./configure --prefix #{File.expand_path(@directory)}"

      if @options[:no_openssl_dir]
        config
      else
        config << " --with-openssl-dir=#{@options[:openssl_dir]}"
      end

      return config
    end

    def build(prefix)
      puts "Building environment in #{prefix}"
      puts "Directory is #{@directory}"
      puts @options[:no_openssl_dir]
      dir = "#{@directory}/ruby-#@version"
      commands = [
        "chmod +x configure tool/ifchange",
        configure_options(prefix),
        "make",
        "make install"
      ]
      commands.each { |command| shell(dir, command) }
    end
  end
end
