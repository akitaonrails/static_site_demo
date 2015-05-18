class Page < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  scope :recent, ->{ order('published_at desc')}

  validates :title, presence: true
  validates :title, uniqueness: true

  before_save :render_markdown

  private

    def render_markdown
      self.summary_html = Markdown2HTML.markdown(summary)
      self.body_html = Markdown2HTML.markdown(body)
    end
end
