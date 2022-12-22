module InterfaceUtils
  module Extensions
    module Sweeper
      extend ActiveSupport::Concern
      
      included do
        @@page_cache_directory = "public"
      end
      
      def cache_configured?
        Rails.configuration.action_controller.cache_configured?
      end
      
      def expire_full_path_page(path)
        expire_page("#{@@page_cache_directory}#{path}")
      end
      
      def default_static_extension
        ActionController::Base.default_static_extension
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
