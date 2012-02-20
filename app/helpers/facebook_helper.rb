# coding: utf-8
module FacebookHelper
  def fb_logo_path
    request.protocol + request.host_with_port + image_path('isb-logo-fb.png')
  end
end
