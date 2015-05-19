class PagesController < ApplicationController
  def index
    @pages = fetch_resources
    if stale?(resources_etag(@pages))
      respond_to do |wants|
        wants.html
      end
    end
  end

  def show
    @page = fetch_resource(params[:id])
    fresh_when last_modified: @page.updated_at.utc, etag: "#{deploy_id}/#{@page.cache_key}", public: true
  end

  private

  def fetch_resources
    cache_key = "#{deploy_id}/pages/limit/10"
    Rails.cache.fetch(cache_key, expires_in: 1.day) { Page.recent.limit(10) }
  end

  def resources_etag(pages)
    recent_updated_at = pages.pluck(:updated_at).max || Time.current
    etag = "#{deploy_id}/pages_index/#{recent_updated_at.iso8601}"
    { last_modified: recent_updated_at.utc, etag: etag, public: true }
  end

  def fetch_resource(id)
    cache_key = "#{deploy_id}/page/#{id}"
    Rails.cache.fetch(cache_key, expires_in: 1.hour) { Page.friendly.find(id) }
  end
end
