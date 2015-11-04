module ApplicationHelper

  # Returns base title if parameter page title empty 
  def full_title(page_title = '')

    base_title = "Application"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

end
