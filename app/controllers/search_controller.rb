class SearchController < ApplicationController

  def index
    @tags = Tag.find_by(tag_name: "#{params[:q]}")
    @follow_count_id_hash = Relationship.group(:following_id).order('count_following_id DESC').limit(3).count(:following_id)
    @follow_count_id = @follow_count_id_hash.keys
    @follow_count_user = User.where(id: @follow_count_id).index_by(&:id)
  end

  def index2
  	@tags = Tag.order("RAND()").limit(5)
  end

  def result
    @tags = Tag.find_by(tag_name: "#{params[:q]}")
  end

end
