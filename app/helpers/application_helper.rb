module ApplicationHelper
  def full_title page_title = ""
    base_title = t "working_space"
    page_title.empty? ? base_title : page_title + " | " + base_title
  end

  def current_index page_index , page_size, index
    (page_index - 1) * page_size + (index + 1)
  end

  def flash_message action, model, is_valid = true
    state = is_valid ? "successfully" : "fail"
    I18n.t "flash.message.#{action}.#{state}",
      model_name: model.model_name.human.titleize
  end

  def flash_class level
    case level
    when :notice then "alert-info"
    when :error then "alert-error"
    when :alert then "alert-warning"
    when :success then "alert-success"
    end
  end
end
