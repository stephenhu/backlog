module Backlog

  class Code 

    attr_accessor :file, :filename, :lines

    def initialize(filename=nil)

      @filename = filename
      @file     = IO.readlines(filename)
      @lines    = @file.length

    end

    def find(filter)

      return @file.grep(filter)

    end

  end

end

