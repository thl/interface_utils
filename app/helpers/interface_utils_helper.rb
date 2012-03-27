#
# This helper is included globally. Make sure to add the stylesheet:
# def stylesheet_files
#  super + ['interface_utils']
# end

module InterfaceUtilsHelper
  
  #
  # Usage: new_item_link(new_admin_blurb_url, "New Blurb"), new_item_link([:blurb]), new_item_link([@parent_object, :citation])
  #
  def new_item_link(path_or_array, text=nil, options={})
    if path_or_array.is_a?(String)
      path = path_or_array
    elsif path_or_array.is_a?(Array)
      # We need to give polymorphic_path an instantiation of a model instead of a symbol if there isn't
      # a parent: [:admin, Feature.new] instead of [:admin, :feature]:
      path_or_array[0] = path_or_array[0].to_s.classify.constantize.new if path_or_array.length == 1
      # All new actions are within the admin namespace, so :admin is added here:
      path_or_array.insert(0, :admin)
      path = new_polymorphic_path path_or_array
      # If text is nil, set it to "New " + model name. For no text, the argument should be set to "". 
      if text.nil?
        model_name = path_or_array.last.is_a?(Symbol) ? path_or_array.last.to_s : path_or_array.last.class.name.tableize.singularize
        # If the displayed model name should be different than the model's actual name, you can define model_display_name(), which
        # should take the actual model name as an argument (e.g. 'feature_geo_code') and return the displayed model name (e.g. 'geo_code').  
        model_name = model_display_name(model_name) if defined? model_display_name
        text = ts('new.record', :what => model_name.titleize.s)
      end
    end
    link_to(text, path, :class => 'item-icon-new', :title => options[:title] || text || ts('new.this'))
  end
  
  #
  # Usage: delete_item_link(object_path(@object), "Remove"), delete_item_link(@object)
  #
  def delete_item_link(path_or_object, text="", options={})
    path = path_or_object.is_a?(String) ? path_or_object : object_path(path_or_object)
    text = "" if text.nil?
    link_to(text, path, :class => 'item-icon-delete', :title => options[:title] || (text.blank? ? nil : text)  || "Delete", :method=>:delete, :confirm=>'WAIT! Are you sure you want to DELETE this item?')
  end
  
  #
  # Usage: edit_item_link(edit_object_path(@object), "Edit"), edit_item_link(@object)
  #
  def edit_item_link(path_or_object, text="", options={})
    path = path_or_object.is_a?(String) ? path_or_object : edit_object_path(path_or_object)
    text = "" if text.nil?
    link_to(text, path, :class => 'item-icon-edit', :title => options[:title] || (text.blank? ? nil : text)  || "Edit")
  end
  
  #
  # Usage: manage_item_link(object_path(@object), "Manage"), manage_item_link(@object)
  #
  def manage_item_link(path_or_object, text="", options={})
    path = path_or_object.is_a?(String) ? path_or_object : object_path(path_or_object)
    text = "" if text.nil?
    link_to(text, path, :class => 'item-icon-manage', :title => options[:title] || (text.blank? ? nil : text)  || "Manage")
  end
  
  #
  # Usage: view_item_link(object_path(@object), "View"), view_item_link(@object)
  #
  def view_item_link(path_or_object, text="", options={})
    path = path_or_object.is_a?(String) ? path_or_object : object_path(path_or_object)
    text = "" if text.nil?
    link_to(text, path, :class => 'item-icon-view', :title => options[:title] || (text.blank? ? nil : text)  || "View")
  end
      
  #
  #
  #
  def highlighted_new_item_link(path_or_array, text=nil, options={})
    "<div class='#{options[:align] || 'left'} highlight'>
      #{new_item_link path_or_array, text, options}
    </div>"
  end
end