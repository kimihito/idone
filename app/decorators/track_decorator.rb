module TrackDecorator
  include Twitter::TwitterText::Autolink
  include Rails.application.routes.url_helpers

  def body
    html = if project
      auto_link_hashtags(raw_body, { :hashtag_url_block => lambda {  |_| project_tracks_path(self.project) } , hashtag_class: 'Label Label--outline bg-blue-light border-white-fade rounded-1 text-bold link-hover-blue' })
    else
      raw_body
    end
    raw html
  end
end
