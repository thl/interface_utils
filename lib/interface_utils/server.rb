module InterfaceUtils
  module Server
    LOCAL       = 1
    DEVELOPMENT = 2
    STAGING     = 3
    PRODUCTION  = 4
    OTHER       = 5
    APOC        = 6
    EBHUTAN     = 7
    
    def self.environment
      Rails.cache.fetch('server/environment') do
        hostname = Socket.gethostname.downcase
        case hostname
        when 'sds6.itc.virginia.edu'     then STAGING
        when 'dev.thlib.org'             then DEVELOPMENT
        when 'dev.thlib.org'             then DEVELOPMENT
        when 'apoc.village.virginia.edu' then APOC
        when 'e-bhutan.bt'               then EBHUTAN
        else
          if hostname =~ /sds.+\.itc\.virginia\.edu/
            PRODUCTION
          elsif hostname.ends_with?('local') || hostname.starts_with?('vpn-user')
            LOCAL
          else
            OTHER
          end
        end
      end
    end
  end
end