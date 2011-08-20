require 'spec_helper'

describe Answer do
  describe "database" do
    it { should have_db_column(:question_option_id) }
    it { should have_db_column(:user_id) }
    it { should have_db_column(:survey_id) }
    it { should have_db_index(:question_option_id) }
    it { should have_db_index(:user_id) }
    it { should have_db_index(:survey_id) }
    it { should belong_to(:question_option) }
    it { should belong_to(:user) }
    it { should belong_to(:survey) }
  end
  
  describe "validation" do
    subject { FactoryGirl.create(:answer) }
    
    it { should validate_presence_of(:question_option) }
    it { should validate_presence_of(:user) }
    it { should validate_uniqueness_of(:user_id).scoped_to(:question_option_id) }
    it { should_not allow_mass_assignment_of(:question_option) }
    it { should_not allow_mass_assignment_of(:survey) }
  end
  
  describe "callbacks" do
    it "should set the survey_id from question_option before save" do
      question  = FactoryGirl.create(:question)
      option    = FactoryGirl.create(:question_option, :question => question)
      answer    = FactoryGirl.create(:answer, :question_option => option)
      answer.survey.should be(question.survey)
    end
  end
  
  describe "alias" do
    it "should respond to option has question_option get/set method" do
      answer = FactoryGirl.create(:answer)
      answer.should respond_to(:option)
      answer.should respond_to(:option=)
      answer.option.should be(answer.question_option)
    end
  end
end
