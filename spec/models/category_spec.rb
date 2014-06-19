require 'spec_helper'

describe Category do
  let(:category) { FactoryGirl.build(:category) }
  subject { category }

  it { should be_valid }

  [:name, :sort_order, :books].each do |field|
    it { should respond_to(field) }
  end

  [:name, :sort_order].each do |field|
    it { should validate_presence_of(field) }
  end

  it { should have_and_belong_to_many(:books) }
end
