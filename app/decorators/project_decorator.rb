module ProjectDecorator
  def icon_image(options = {})
    image_tag 'data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7', options.merge(data: { controller: 'avatar', 'avatar-seed': title, src: "#{icon.attached? ? url_for(icon.variant(combine_options: { resize: '150x150^', crop: '150x150+0+0', gravity: :center })) : '' }" })
  end

  def description_with_placeholder
    description.presence || t('decorators.projects.description.placeholder')
  end
end
