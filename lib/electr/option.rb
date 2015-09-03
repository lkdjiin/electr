module Electr

  # Process command line switches.
  #
  # The keys you are going to use:
  #
  # :ast        - Boolean, if true the user want to print the Abstract
  #               Syntax Tree and quit.
  # :expression - Don't run interactively, parse this String and quit.
  #
  # Examples
  #
  #   opt = Option.new
  #   if opt[:expression]
  #     puts "Doing the job with #{opt[:expression]}"
  #   end
  class Option

    # Creates a new Option instance.
    def initialize
      @options = { ast: false }

      optparse = OptionParser.new {|opts| parse(opts) }

      begin
        optparse.parse!
      rescue OptionParser::InvalidOption => exception
        puts exception.to_s
        exit 1
      end

      print_version if @options[:version]
    end

    # Get an option.
    #
    # key - The Symbol name of the option to get.
    #
    # Returns Any value corresponding of the key, or nil if the key
    #   doesn't exists.
    def [](key)
      @options[key]
    end

    def parse(opts)
      opts.on('-a', '--ast', 'Display AST and quit') do
        @options[:without_header] = true
      end
      opts.on('-e', '--expression EXP', 'Compute EXP and quit') do |arg|
        @options[:expression] = arg
      end
      opts.on('-v', '--version', 'Print version number and exit') do
        @options[:version] = true
      end
      opts.on('-h', '--help', 'Display this screen') do
        puts opts
        exit
      end
    end

    private

    def print_version
      puts "Electr version #{VERSION}"
      exit
    end

  end

end
