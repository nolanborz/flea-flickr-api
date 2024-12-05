class StaticPagesController < ApplicationController
  def home
    if params[:flickr_id].present?
      flickr = Flickr.new do |config|
        config.api_key = Rails.application.credentials.flickr.api_key
        config.shared_secret = Rails.application.credentials.flickr.shared_secret
      end

      begin
        @photos = flickr.people.getPublicPhotos(user_id: params[:flickr_id])
      rescue Flickr::FailedResponse => e
        flash.now[:alert] = "Invalid Flickr ID or error fetching photos"
        @photos = []
      end
    end
  end
end
