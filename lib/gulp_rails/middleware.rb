module GulpRails
  class Middleware
  
    def initialize(app)
      @app = app
    end
  
    def call(env)
      result = @app.call(env)
      if GulpRails.options[:enabled] && (GulpRails.options[:development_only] && Rails.env.development?)
        if result[1]['Content-Type'] =~ /\Atext\/html/
          log "-----> Compiling assets with gulp"
          gulp_output = `cd #{GulpRails.options[:directory]} && #{GulpRails.options[:command]}`
          log gulp_output.strip.split("\n").map { |l| "       #{l}"}.join("\n")
          log "-----> Finished compiling with gulp"
        end
      end
      result
    end
    
    private
    
    def log(line)
      Rails.logger.debug line
    end
  
  end
end
