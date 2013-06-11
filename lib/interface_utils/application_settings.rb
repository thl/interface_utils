module InterfaceUtils
  module ApplicationSettings
    private

    def self.settings
      settings = Rails.cache.fetch('application_settings/hash', :expires_in => 1.day) do
        settings_file = Rails.root.join('config', 'settings.yml')
        settings_file.exist? ? YAML.load_file(settings_file) : {}
      end
    end
  end
end