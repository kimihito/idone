module UserDecorator
  def icon_image(options = {})
    image_tag 'data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7', options.merge(data: { controller: 'avatar', 'avatar-seed': name, src: "#{icon.attached? ? url_for(icon.variant(combine_options: { resize: '150x150^', crop: '150x150+0+0', gravity: :center })) : '' }" })
  end
end