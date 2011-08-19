require 'spec_helper'

describe Survey do
  describe "database" do
    it { should have_db_column(:user_id).of_type(:integer) }
    it { should have_db_column(:title).of_type(:string) }
    it { should have_db_column(:is_private).of_type(:boolean).with_options(:default => false) }
    it { should have_db_index(:user_id).unique(false) }
    it { should belong_to(:user) }
    it { should have_many(:questions) }
  end
  
  describe "validations" do
    subject { FactoryGirl.create(:survey) }
    
    it { should be_valid }
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:title) }
    it { should ensure_length_of(:title).is_at_least(3) }
    
    it "should not save a survey without a valid user" do
      @survey = FactoryGirl.build(:survey, :user_id => 0)
      @survey.should_not be_valid
      @survey.user.should be_nil
    end
  end
  
  describe "methods" do
    it "should respond to private? method" do
      @survey = FactoryGirl.create(:survey)
      @survey.respond_to?(:private?).should be_true
    end
    
    it "should collect all the users that answered this survey" do
      pending
    end
  end
end
