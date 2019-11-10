class My::TagsController < MyController
  def index
    tags = Tag.union(Tag.joins(:track).where(tracks: { owner: current_user }), Tag.joins(:project).where(projects: { owner: current_user }))
    skip_authorization
    render json: TagSerializer.new(tags).serialized_json
  end
end