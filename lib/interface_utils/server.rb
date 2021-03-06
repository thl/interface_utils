module InterfaceUtils
  module Server
    LOCAL       = 1
    DEVELOPMENT = 2
    STAGING     = 3
    PRODUCTION  = 4
    OTHER       = 5
    
    def self.enable_localhost?
      enable_localhost = Rails.cache.fetch("application_settings/#{InterfaceUtils::Server.get_domain}/enable_localhost", :expires_in => 1.day) do
        str = InterfaceUtils::ApplicationSettings.settings['enable.localhost']
        break false if str.blank?
        str.downcase!
        str.strip!
        str=='yes'
      end
    end
    
    def self.environment
      Rails.cache.fetch('server/environment', :expires_in => 1.day) do
        environ = InterfaceUtils::ApplicationSettings.settings['server.environment']
        environ.downcase!
        environ.strip!
        case environ
        when 'local'       then LOCAL
        when 'development' then DEVELOPMENT
        when 'staging'     then STAGING
        when 'production'  then PRODUCTION
        else OTHER
        end
      end
    end
    
    def self.get_thl_url
      Rails.cache.fetch('server/thl-domain', :expires_in => 1.day) do
        case environment
        when DEVELOPMENT then 'http://dev.thlib.org'
        when STAGING     then 'http://staging.thlib.org'
        else                  'http://www.thlib.org'
        end
      end
    end
  end
end