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

    def get_tasks

      tasks = Array.new

      todo = find(/[#]+[\s\t]*(TODO)/)

      todo.each do |t|

        tmp = t.sub( /[#]+/, "" )
        csv = tmp.sub( /(TODO:|TODO)/, "" ).strip + ", #{@filename}"
        tasks << csv

      end

      return tasks

    end

  end

end

