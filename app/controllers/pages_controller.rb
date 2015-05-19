class PagesController < ApplicationController
  def index
    @pages = fetch_resources
    if stale?(etag: resources_etag(@pages), public: true)
      respond_to do |wants|
        wants.html
      end
    end
  end

  def show
    @page = fetch_resource(params[:id])
    fresh_when etag: "#{deploy_id}/#{@page.cache_key}", public: true
  end

  private

  def fetch_resources
    cache_key = "#{deploy_id}/pages/limit/10"
    Rails.cache.fetch(cache_key, expires_in: 1.day) { Page.recent.limit(10) }
  end

  def resources_etag(pages)
    recent_updated_at = pages.pluck(:updated_at).max || Time.current
    "#{deploy_id}/pages_index/#{recent_updated_at.iso8601}"
  end

  def fetch_resource(id)
    cache_key = "#{deploy_id}/page/#{id}"
    Rails.cache.fetch(cache_key, expires_in: 1.hour) { Page.friendly.find(id) }
  end
end
