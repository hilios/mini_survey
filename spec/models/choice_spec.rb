require 'spec_helper'

describe Choice do
  describe "database" do
    it { should have_db_column(:question_id).of_type(:integer) }
    it { should have_db_column(:title).of_type(:text) }
    it { should have_db_index(:question_id).unique(false) }
    it { should belong_to(:question) }
    it { should have_many(:answers) }
  end
  
  describe "validations" do
    subject { FactoryGirl.create(:choice) }
    
    it { should validate_presence_of(:question) }
    it { should validate_presence_of(:title) }
    it { should ensure_length_of(:title).is_at_least(3) }
  end
end
