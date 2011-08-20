require 'spec_helper'

describe Question do
  describe "database" do
    it { should have_db_column(:survey_id).of_type(:integer) }
    it { should have_db_column(:number).of_type(:integer) }
    it { should have_db_column(:title).of_type(:text) }
    it { should have_db_index(:survey_id).unique(false) }
    it { should belong_to(:survey) }
    it { should have_many(:question_options) }
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
    
    describe "alias" do
      it "should respond to option has question_option get/set method" do
        question = FactoryGirl.create(:question)
        FactoryGirl.create_list(:question_option, 5, :question => question)
        question.should respond_to(:options)
        question.should respond_to(:options=)
        question.options.should have(5).question_option
        question.options.each do |option|
          option.class.should be(QuestionOption)
          option.question.id.should be(question.id)
        end
      end
    end
    
    it "should return the questions ordered by number" do
      survey = FactoryGirl.create(:survey)
      FactoryGirl.create(:question, :number => 3, :survey => survey)
      FactoryGirl.create(:question, :number => 2, :survey => survey)
      FactoryGirl.create(:question, :number => 5, :survey => survey)
      FactoryGirl.create(:question, :number => 1, :survey => survey)
      FactoryGirl.create(:question, :number => 4, :survey => survey)
      i = 1
      Question.from_survey(survey).numbered.each do |question|
        question.number.should be(i)
        i += 1
      end
    end
  end
  
  describe "methods" do
    it "should return the total answers" do
      question  = FactoryGirl.create(:question)
      options = FactoryGirl.create_list(:question_option, 5, :question => question)
      total = 0
      options.each_with_index do |option, i|
        FactoryGirl.create_list(:answer, i, :question_option => option)
        total += i
      end
      question.total.should == total
    end
  end
end
