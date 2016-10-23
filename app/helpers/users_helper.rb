module UsersHelper

  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end

  def add_one_users(skill_id,user_id)
    current_skill = Skill.find(skill_id)
    get_tagged_user_id = current_skill.user_skills.where(user_id: user_id)

    tagged_user_array = []

    get_tagged_user_id.each do |row|
      # tagged_user_id=nilなものが必ず存在。
      unless row.tagged_user_id.nil?
        tagged_user_array << User.find(row.tagged_user_id)
      end
    end

    # 最大10人まで表示するため、配列内の要素を10に限定。
    tagged_user_array.take(10)
  end

  def skill_hidden?(skill_id)
    hide_skill = Hide.where(user_id: current_user.id).where(hide_skill_id: skill_id)

    if hide_skill.size == 0
      return false
    else
      return true
    end
  end

end
