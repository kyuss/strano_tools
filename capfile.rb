require 'capistrano/cli'
require 'fileutils'

  class Capfile

    def initialize(path, stage = nil)
      @path = path
      @cap = load(stage)
    end

    def tasks
      cap_tasks
    end

    def stages
      cap_stages
    end

    def variables
      @cap.variables
    end

    private

    def load(stage)
      def build_query(stage)
        if stage.nil?
          return  %W(-f Capfile -Xx -l STDOUT)
        else 
          return %W(-f Capfile -Xx -l STDOUT #{stage})
        end
      end
        
      FileUtils.chdir @path do    
        return Capistrano::CLI.parse(build_query(stage)).execute!         
      end     
    end

    def cap_tasks      
      return Hash[@cap.task_list(:all).sort_by(&:fully_qualified_name).map {|task|
        [task.fully_qualified_name,task.description]
      }]     
    end

    def cap_stages
      def filter(variables)
        return variables.select{|key, name| name.is_a?(String)}
      end

      if !@cap.variables[:stages].nil?
        return Hash[
          @cap.variables[:stages].map do |stage|   
            [stage, filter(Capfile.new(@path, stage).variables)]
          end
        ]
      else
        return Hash["default",filter(@cap.variables)]
      end      
    end
end
