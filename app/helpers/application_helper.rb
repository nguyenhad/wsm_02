module ApplicationHelper
  def full_title page_title = ""
    base_title = t "working_space"
    page_title.empty? ? base_title : page_title + " | " + base_title
  end

  def current_index page_index , page_size, index
    (page_index - 1) *page_size + (index + 1)
  end
end
