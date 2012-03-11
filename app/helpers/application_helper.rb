module ApplicationHelper
  def html5_datetime(time)
    if time.is_a? Time
      #Eastern European Time (UTC+2)
      return time.strftime('%Y-%m-%dT%H:%M:%S') + time.formatted_offset(true)
    else
       return time.to_s
    end
  end

  def title(page_title)
    content_for(:title) { page_title }
  end

  def description(page_description)
    content_for(:description) { page_description }
  end
end
