require 'spec_helper'

describe Answer do
  describe "database" do
    it { should have_db_column(:question_id) }
    it { should have_db_column(:choice_id) }
    it { should have_db_column(:user_id) }
    it { should have_db_column(:survey_id) }
    it { should have_db_index(:question_id) }
    it { should have_db_index(:choice_id) }
    it { should have_db_index(:user_id) }
    it { should have_db_index(:survey_id) }
    it { should belong_to(:choice) }
    it { should belong_to(:user) }
    it { should belong_to(:survey) }
  end
  
  describe "validation" do
    subject { FactoryGirl.create(:answer) }
    
    it { should validate_presence_of(:choice) }
    it { should validate_presence_of(:user) }
    it { should validate_uniqueness_of(:user_id).scoped_to(:choice_id) }
    it { should_not allow_mass_assignment_of(:question) }
    it { should_not allow_mass_assignment_of(:survey) }
  end
  
  describe "callbacks" do
    it "should set the survey_id from question_option before save" do
      question  = FactoryGirl.create(:question)
      choice    = FactoryGirl.create(:choice, :question => question)
      answer    = FactoryGirl.create(:answer, :choice => choice)
      answer.survey.should be(question.survey)
    end
  end
end
