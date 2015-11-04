module UsersHelper

  # Return avatar for user
  def avatar_user(user)
    avatar_id  = Digest::MD5::hexdigest(user.email.downcase)
    avatar_url = "https://secure.gravatar.com/avatar/#{avatar_id}"
    image_tag(avatar_url, alt: user.name, class: "avatar") 
  end

end
