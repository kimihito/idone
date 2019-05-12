module TrackDecorator
  include Twitter::TwitterText::Autolink
  include Rails.application.routes.url_helpers

  def body
    html = auto_link_hashtags(raw_body, { :hashtag_url_block => lambda {  |_| project_tracks_path(self.project) } , hashtag_class: 'Label Label--gray'})
    raw html
  end
end
