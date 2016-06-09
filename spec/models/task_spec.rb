require 'rails_helper'

RSpec.describe Task, type: :model do
  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }
  it { should validate_presence_of :state }
  it { should validate_presence_of :project }

  it 'should initialize state to todo' do
    # Given
    # No setup needed for this test

    # When
    target = build(:task)

    # Then
    expect(target.state).to eql('todo')
  end
end
