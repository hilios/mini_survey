require 'spec_helper'

describe Question do
  describe "database" do
    it { should have_db_column(:survey_id).of_type(:integer) }
    it { should have_db_column(:number).of_type(:integer) }
    it { should have_db_column(:title).of_type(:text) }
    it { should have_db_index(:survey_id).unique(false) }
    it { should belong_to(:survey) }
    it { should have_many(:choices) }
    it { should have_many(:answers) }
  end
  
  describe "validation" do
    subject { FactoryGirl.create(:question) }
    
    it { should be_valid }
    it { should validate_presence_of(:survey) }
    it { should validate_numericality_of(:number) }
    it { should_not allow_value(0).for(:number) }
    it { should_not allow_value(0.5).for(:number) }
    it { should validate_presence_of(:title) }
    
    it "should not save a question without a valid survey" do
      @question = FactoryGirl.build(:question, :survey_id => 0)
      @question.should_not be_valid
      @question.survey.should be_nil
    end
  end
  
  describe "scope" do
    it "should return the questions from survey" do
      survey = FactoryGirl.create(:survey)
      FactoryGirl.create_list(:question, 5, :survey => survey)
      FactoryGirl.create_list(:question, 10)
      Question.from_survey(survey).length.should be(5)
      Question.from_survey(survey.id).length.should be(5)
    end
  end
  
  describe "methods" do
    it "should return the total answers" do
      question  = FactoryGirl.create(:question)
      choices = FactoryGirl.create_list(:choice, 5, :question => question)
      total = 0
      choices.each_with_index do |choice, i|
        FactoryGirl.create_list(:answer, i, :choice => choice)
        total += i
      end
      question.total.should == total
    end
  end
  
  describe "nested attributes" do
    it "should nest questions" do
      question  = FactoryGirl.create(:question)
      question.choices_attributes = [{:title => 'foo'}, {:title => 'bar'}]
      question.save!
      question.choices.count.should be(2)
    end
  end
end
