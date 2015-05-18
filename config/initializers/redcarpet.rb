require 'redcarpet'
require 'rouge'
require 'rouge/plugins/redcarpet'

class Markdown2HTML < Redcarpet::Render::HTML
  RENDER_OPTIONS = {
    filter_html:     true,
    hard_wrap:       true,
    link_attributes: { rel: 'nofollow' }
  }

  EXTENSIONS = {
    autolink:           true,
    fenced_code_blocks: true,
    lax_spacing:        true,
    no_intra_emphasis:  true,
    strikethrough:      true,
    superscript:        true
  }

  # to use Rouge with Redcarpet
  include Rouge::Plugins::Redcarpet

  def self.markdown(text)
    return nil unless text.present?
    renderer = Markdown2HTML.new(RENDER_OPTIONS)
    redcarpet = Redcarpet::Markdown.new(renderer, EXTENSIONS)
    redcarpet.render(text).html_safe
  end
end
