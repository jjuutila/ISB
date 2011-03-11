# coding: utf-8
module MemberHelper
  def show_pic_for(member)
    if FileTest.exists? path_to_image "members/#{member.id}.jpg"
      puts "player"
      image_tag "members/#{member.id}.jpg", :alt => member
    else
      image_tag "members/default.jpg", :alt => "Oletuskuva"
    end
  end
  
  def translate_position position

  end
end