require 'capistrano/cli'
require 'fileutils'
	
  class Capfile

    def initialize(path, stage = nil)
      @path = path
      @cap = load(stage)
      puts @cap.branch
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
          return %W(-f Capfile -Xx -l STDOUT)
        else 
          return %W(-f Capfile -Xx -l STDOUT #{stage})
        end
      end
    
      FileUtils.chdir @path do    
        return Capistrano::CLI.parse(build_query(stage)).execute!         
      end     
    end

    def cap_tasks      
      @cap.task_list(:all).sort_by(&:fully_qualified_name).map {|task|
         {
          :name => task.fully_qualified_name, 
          :description => task.description, 
          :brief_description => task.brief_description
        }
      }     
    end

    def cap_stages
      def filter(variables)
        variables.select { |key, name| name.is_a?(String) }
      end

      if !@cap.variables[:stages].nil?     
         @cap.variables[:stages].map do |stage|           
            {
              :name => stage,
              :variables => filter(Capfile.new(@path, stage).variables)
            }
          end        
      else
        [{
          :name => "default", 
          :variables => filter(@cap.variables)
        }]
      end      
    end
end
