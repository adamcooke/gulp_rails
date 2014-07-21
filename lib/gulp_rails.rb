require 'gulp_rails/railtie'

module GulpRails
  
  def self.options
    @options ||= {
      :enabled          => true,
      :command          => 'gulp',
      :directory        => Rails.root.join('frontend'),
      :development_only => true
    }
  end
  
end