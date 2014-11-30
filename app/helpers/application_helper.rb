module ApplicationHelper
  def page_description
    @page_description || Settings.site.description
  end

  def page_title
    return "#{@page_title} – #{Settings.site.title}" if @page_title
    "#{Settings.site.title} – #{Settings.site.description}"
  end
end
