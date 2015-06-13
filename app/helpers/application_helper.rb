module ApplicationHelper

  # set some classes on <body>
  def body_class
    result = [ params[:controller].gsub('/','_'), params[:action] ]

    # sometimes, we need to hide some things in development that are annoying
    if (session['development_mode'].present? && session['development_mode']) && Rails.env.development?
      result << "development_mode"
    end

    result.join(' ')
  end

  ### --------- site defaults --------- ###
  def company_name
    Secrets.base_company_name
  end
  
  def site_title
    case params[:controller]
    when "errors"
      case params[:action]
      when "not_found_404"
        "404 – #{base_site_title}"
      when "internal_error_500"
        "500 – #{base_site_title}"
      when "unprocessable_entity_422"
        "422 – #{base_site_title}"
      end
    else
      "#{company_name} | #{base_site_title}"
    end
  end
  
  def base_site_title
    Secrets.base_site_title
  end

  ## meta / social stuff
  def page_meta_description
    "Meta description here."
  end

  def page_meta_keywords
    "keywords, go, here"
  end
  ## END meta / social stuff

  ## fb stuff
  def fb_page_title
    site_title
  end
  
  def fb_type
    "website"
  end
  
  def fb_image
    "http://#{Secrets.app_url}#{asset_path 'fb_image.png'}"
  end
  
  def fb_description
    if page_meta_description.present?
      page_meta_description
    else
      site_title
    end
  end
  ## END fb stuff

  ### END ------ site defaults --------- ###

end
