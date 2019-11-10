class My::TagsController < MyController
  def index
    tags = Tag.used_by(owner: current_user)
    skip_authorization
    render json: TagSerializer.new(tags).serialized_json
  end
end