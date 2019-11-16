module Projects::UpdateDecorator
  def icon_image(options = {})
    image_tag 'data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7', options.merge(data: { controller: 'avatar', 'avatar-seed': project.title, src: "#{project.icon.attached? ? url_for(project.icon.variant(combine_options: { resize: '150x150^', crop: '150x150+0+0', gravity: :center })) : '' }" })
  end
end