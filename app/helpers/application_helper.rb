module ApplicationHelper
  
  def active_class(url = '')
    'active' if current_page?(url)
  end
  
  def active_section_class(section = '')
    'active' if params[:controller].include?(section)
  end
  
end
