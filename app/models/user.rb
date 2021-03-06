class User < ActiveRecord::Base
  has_many :relations

  def slow_mutual_friend_ids(friend)
    Relation.joins("JOIN relations t2 on relations.friend_id = t2.user_id")
      .where("relations.user_id = ? AND t2.friend_id = ?", id, friend.id)
      .select("relations.friend_id")
      .map(&:friend_id)
      .uniq
  end

  def mutual_friends(friend)
    User.where(id: slow_mutual_friend_ids(friend))
  end
end
