module InterfaceUtils
  module Extensions
    module Sweeper
      extend ActiveSupport::Concern
      
      included do
        @@page_cache_directory = Rails.configuration.action_controller.page_cache_directory
        relative_root = ActionController::Base.relative_url_root
        @@page_cache_directory << relative_root if !relative_root.blank?
      end
      
      def cache_configured?
        Rails.configuration.action_controller.cache_configured?
      end
      
      def expire_full_path_page(path)
        expire_page("#{@@page_cache_directory}#{path}")
      end
      
      module ClassMethods
        # Very weird! ActionController::Caching seems to assume it is being called from controller. Adding this as hack
        def perform_caching
          Rails.configuration.action_controller.perform_caching
        end
        
        def default_static_extension
          Rails.configuration.default_static_extension
        end
      end
    end
  end
end