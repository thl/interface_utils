module FrameHelper

  #controller-type methods -- where should these go?

  def frame_init
    unless should_destroy() || params[:parent_url].blank?
      parent_url = params[:parent_url]
      css_url = params[:css_url]
      set_parent_url( parent_url )
      set_css_url( css_url ) unless css_url.blank?      
    end
    # $html_start = nil not ideal -- means that load_attributes is called every time, but sufficient for now
  end

  def get_parent_url
    return params[:parent_url] || session[:parent_url] #had to add the conditional because of ie's asynch issues
  end

  def get_css_url
    return params[:css_url] || session[:css_url] #had to add the conditional because of ie's asynch issues
  end

  def in_frame?
    return !get_parent_url.nil?
  end

  def kill_session_vars
    set_parent_url( nil )
    set_css_url( nil )
  end

  def set_css_url( val )
    session[:css_url] = val
  end

  def set_parent_url( val )
    session[:parent_url] = val
  end

  def should_destroy
    if params[:frame] == 'destroy' #message from other context
      kill_session_vars()
      #reset_session() #this is what we'd like to do but out of scope here
      return true
    end
    return false
  end
  

  #view methods

  def abs_url
    u = 'http'
    u += 's' if request.ssl?
    u += '://'
    u += request.host
    u += ":#{request.port}" unless request.port.blank?
    u += request.fullpath
    return u
  end

  def frame_bookmark
    return "#{get_parent_url}#iframe=#{abs_url}"
  end

  def frame_css
    if in_frame?
      if css_url = get_css_url()
      else css_url = "#{InterfaceUtils::Server.get_thl_url}/global/css/thdl-style.css" #temporary solution
      end
      return stylesheet_link_tag css_url
    end
  end

  def frame_height
    y = params[:y].to_s.to_i - 5
    return y.to_s
  end

  def frame_js
    return javascript_include_tag 'thl_integration/service_plug' if in_frame?
  end
  
  def www_js
    return javascript_include_tag "#{InterfaceUtils::Server.get_thl_url}/global/php/combineJS.php" if in_frame?
  end

  def frame_width
    x = params[:x].to_s.to_i - 5
    return x.to_s
  end

end