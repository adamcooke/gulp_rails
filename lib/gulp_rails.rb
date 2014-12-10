require 'open3'
require 'gulp_rails/railtie'

module GulpRails
  class CompilationFailed < RuntimeError
  end

  def self.options
    @options ||= {
      :enabled          => true,
      :command          => 'gulp',
      :args             => '',
      :directory        => Rails.root.join('frontend'),
      :development_only => true,
      :hide_errors      => false
    }
  end
  
end