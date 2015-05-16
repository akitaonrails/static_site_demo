require 'rails_helper'

RSpec.describe Page, type: :model do
  it 'validates presence of title' do
    subject.valid?
    expect(subject.errors).to include(:title)
  end
end
