module InterfaceUtils
  module Extensions
    module Sweeper
      extend ActiveSupport::Concern
  
      def cache_configured?
        Rails.configuration.action_controller.cache_configured?
      end

      included do
      end
  
      module ClassMethods
        # Very weird! ActionController::Caching seems to assume it is being called from controller. Adding this as hack
        def perform_caching
          Rails.configuration.action_controller.perform_caching
        end
      end
    end
  end
end