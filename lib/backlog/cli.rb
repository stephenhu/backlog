module Backlog

  class CLI < Thor

    EXTENSIONS = [ "rb" ]

    desc( "collect", "collects tasks from source files" )
    method_option :path, :aliases => "-d", :type => :string,
      :required => false, :desc => "directory for collection"
    method_option :exclude, :aliases => "-x", :type => :string,
      :required => false, :desc => "files to exclude from collection"
    method_option :recursive, :aliases => "-R", :type => :boolean,
      :required => false, :desc => "recurse directory flag", :default => true
    method_option :target, :aliases => "-o", :type => :string,
      :required => false, :desc => "backlog output file"
    def collect

      @path     = options[:path] || "."
      @path     = @path + "/**/*.rb"
      @backlog  = options[:target] || "./backlog"

      filenames = Dir.glob(@path)

      filenames.each do |f|

        c = Code.new(f)
 
        todo  = c.find(/[#]+[\s\t]*(TODO)/)
        tasks = parse(todo)

      end

    end

    no_tasks do

      def parse(todo)

        todo.each do |t|

          tmp = t.sub( /[#]+/, "" )
          store(tmp.sub( /(TODO:|TODO)/, "" ).strip)

        end

      end

      def store(task)

        f = File.open( @backlog, "a+" )
        f.write("#{task}\n")
        f.close

      end

    end

  end

end

