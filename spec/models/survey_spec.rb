require 'spec_helper'

describe Survey do
  describe "database" do
    it { should have_db_column(:user_id).of_type(:integer) }
    it { should have_db_column(:title).of_type(:string) }
    it { should have_db_column(:is_private).of_type(:boolean).with_options(:default => false) }
    it { should have_db_index(:user_id).unique(false) }
    it { should belong_to(:user) }
    it { should have_many(:questions).dependent(:destroy) }
    it { should have_and_belong_to_many(:watches) }
  end
  
  describe "validations" do
    subject { FactoryGirl.create(:survey) }
    
    it { should be_valid }
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:title) }
    it { should ensure_length_of(:title).is_at_least(3) }
    
    it "should not save a survey without a valid user" do
      survey = FactoryGirl.build(:survey, :user_id => 0)
      survey.should_not be_valid
      survey.user.should be_nil
    end
  end
  
  describe "methods" do
    it "should respond to private? method" do
      survey = FactoryGirl.create(:survey)
      survey.respond_to?(:private?).should be_true
    end
    
    it "should count the unique users that answered a survey" do
      survey = FactoryGirl.create(:survey)
      question  = FactoryGirl.create(:question, :survey => survey)
      choices = FactoryGirl.create_list(:choice, 5, :question => question)
      total = 0
      choices.each_with_index do |choice, i|
        FactoryGirl.create_list(:answer, i, :choice => choice)
        total += i
      end
      survey.total.should == total
    end
  end
  
  describe "scope" do
    it "should find all survey that are no privated" do
      FactoryGirl.create_list(:private_survey, 5)
      FactoryGirl.create_list(:survey, 5)
      Survey.count.should be(10)
      Survey.not_private.count.should be(5)
    end
  end
  
  describe "nested attributes" do
    it "should accept many questions" do
      survey = FactoryGirl.create(:survey)
      survey.questions_attributes = [{:title => 'foo'}, {:title => 'bar'}, {:title => nil}]
      survey.save!
      survey.questions.count.should be(2)
    end
  end
  
  describe "delegate" do
    before(:each) do
      @survey = FactoryGirl.create(:survey)
    end
    
    it "should delegate the user_name attr to user object" do
      @survey.user_name.should be(@survey.user.name)
    end
    
    it "should fail silently if user is not present" do
      @survey.user = nil
      @survey.user_name.should be_nil
    end
  end
end
