module GulpRails
  class Railtie < Rails::Railtie
    initializer 'gulp_rails.initialize' do |app|
      require 'gulp_rails/middleware'
      app.config.middleware.use GulpRails::Middleware
    end
  end
end
