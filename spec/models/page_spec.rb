require 'rails_helper'

RSpec.describe Page, type: :model do
  context '.valid?' do
    before { subject.valid? }
    it 'validates presence of title' do
      expect(subject.errors).to include(:title)
    end
  end

  context 'render from markdown' do
    let(:sample_path)    { File.join('spec/fixtures/sample.mdown') }
    let(:content)        { File.read(sample_path) }
    let(:html_path)      { File.join('spec/fixtures/sample.html') }
    let(:result_content) { File.read(html_path) }
    it 'renders HTML' do
      subject.title = 'test'
      subject.body = content
      subject.save
      expect(subject.body_html).to eq(result_content)
    end
  end
end
