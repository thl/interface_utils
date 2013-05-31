module InterfaceUtils
  class Engine < ::Rails::Engine
    initializer :assets do |config|
      Rails.application.config.assets.precompile.concat(['interface_utils/customtinymce.css'])
    end
  end
end
