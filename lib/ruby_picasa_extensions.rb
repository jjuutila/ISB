module RubyPicasaUserExtension
  def find_album_by_name(name)
    unless a = albums.find { |a| name === a.name }
      raise ActiveRecord::RecordNotFound, "Album not found with name '#{name}'."
    end
    a
  end
end

module RubyPicasaAlbumExtension
  def find_photo(id)
    unless photo = photos.find { |p| p.id.to_s == id }
      raise ActiveRecord::RecordNotFound, "Photo not found with id '#{id}'."
    end
    photo
  end
end
