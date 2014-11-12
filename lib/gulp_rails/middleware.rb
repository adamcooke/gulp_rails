module GulpRails
  class Middleware
  
    def initialize(app)
      @app = app
    end
  
    def call(env)
      result = @app.call(env)

      if GulpRails.options[:enabled] && (GulpRails.options[:development_only] && Rails.env.development?)
        if result[1]['Content-Type'] =~ /\Atext\/html/
          log("[GULP:DEBUG ] Starting the compilation in the folder #{GulpRails.options[:directory]}")
          log("[GULP:DEBUG ]   Running command: #{GulpRails.options[:command]}")
          perform_execution
        end
      end

      result
    end
    
    private
    
    def log(line)
      Rails.logger.debug(line)
    end

    def perform_execution
      command = GulpRails.options[:command]
      args = GulpRails.options[:args]
      directory = GulpRails.options[:directory]
      hide_errors = GulpRails.options[:hide_errors]

      begin
        pid = value = output = nil

        Open3.popen2e("#{command} #{args}", chdir: directory) do |stdin, stdout_err, thread|
          pid = thread.pid
          value = thread.value
          output = stdout_err.read
        end

        log("[GULP:DEBUG ]   Process #{pid} exited with status #{value} and output:")
        log(output.strip.split("\n").map { |l| "[GULP:OUTPUT]     #{l}"}.join("\n"))
        raise(GulpRails::CompilationFailed, output) unless value.success? || hide_errors
      rescue Errno::ENOENT
        log("[GULP:ERROR ]   The Gulp executable #{command} was not found within directory #{directory}.")
        raise(GulpRails::CompilationFailed, "Gulp executable #{command} not found within #{directory}.") unless hide_errors
      end
    end

  end
end