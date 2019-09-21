module TrackDecorator
  include Twitter::TwitterText::Autolink
  include Rails.application.routes.url_helpers

  def body
    html = auto_link_hashtags(raw_body, { :hashtag_url_block => lambda {  |_| project_tracks_path(self.project) } , hashtag_class: 'Label Label--outline bg-blue-light border-white-fade rounded-1 text-bold link-hover-blue' })
    raw html
  end
end
