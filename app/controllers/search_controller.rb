class SearchController < ApplicationController

  def index
    @tags = Tag.find_by(tag_name: "#{params[:q]}")
  end
end