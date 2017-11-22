class Like < ActiveRecord::Base
  belongs_to :micropost, counter_cache: :likes_count
  belongs_to :user
end
