module UsersHelper

  # Return avatar for user
  def avatar_user(user, size = '80')
    avatar_size = size
    avatar_id   = Digest::MD5::hexdigest(user.email.downcase)
    avatar_url  = "https://secure.gravatar.com/avatar/#{avatar_id}?s=#{size}"
    image_tag(avatar_url, alt: user.name, class: "avatar") 
  end

end
