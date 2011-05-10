# coding: utf-8

module PicasaHelper
  def picasa_pagination
    photo_index = @album.photos.find_index { |p| p.id.to_s == @photo.id.to_s }
    
    return nil unless photo_index
    p = "<nav class='photo-pagination'>"
    
    if photo_index > 0
      p << link_to('< Edellinen', photo_path(@section.slug, @album.name, @album.photos[photo_index - 1].id))
    end
    
    p << link_to('Näytä kaikki', album_path(@section.slug, @album.name))
    
    if (photo_index < (@album.photos.count - 1))
      p << link_to('Seuraava >', photo_path(@section.slug, @album.name, @album.photos[photo_index + 1].id))
    end
    
    p << "</nav>"
    p.html_safe
  end
end
