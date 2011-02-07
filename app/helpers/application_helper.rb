module ApplicationHelper
  def html5_datetime(time)
    puts time.class
    if time.is_a? Time
      #Eastern European Time (UTC+2)
      return time.strftime('%Y-%m-%dT%H:%M:%S') + time.formatted_offset(true)
    else
       return time.to_s
    end
  end
end
