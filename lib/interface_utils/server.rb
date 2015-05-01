module InterfaceUtils
  module Server
    LOCAL       = 1
    DEVELOPMENT = 2
    STAGING     = 3
    PRODUCTION  = 4
    OTHER       = 5
    APOC        = 6
    EBHUTAN     = 7
    
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
        hostname = Socket.gethostname.downcase
        case hostname
        when 'sdsv11.its.virginia.edu'   then STAGING
        when 'dev.thlib.org'             then DEVELOPMENT
        when 'apoc.village.virginia.edu' then APOC
        when 'e-bhutan.bt'               then EBHUTAN
        else
          if hostname =~ /sds.+\.it[c|s]\.virginia\.edu/
            PRODUCTION
          elsif enable_localhost? && (hostname.ends_with?('local') || hostname.starts_with?('vpn-user'))
            LOCAL
          else
            OTHER
          end
        end
      end
    end
  end
end