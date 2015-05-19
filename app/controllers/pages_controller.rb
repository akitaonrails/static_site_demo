class PagesController < ApplicationController
  def index
    @pages = Page.recent.limit(10)
    recent_updated_at = @pages.pluck(:updated_at).max || Time.current
    etag = "#{deploy_id}/products_index/#{recent_updated_at.iso8601}"
    if stale?(etag: etag, public: true)
      respond_to do |wants|
        wants.html
      end
    end
  end

  def show
    @page = Page.friendly.find(params[:id])
    fresh_when etag: "#{deploy_id}/#{@page.cache_key}", public: true
  end
end
