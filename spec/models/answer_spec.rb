require 'spec_helper'

describe Answer do
  describe "database" do
    it { should have_db_column(:question_option_id) }
    it { should have_db_column(:user_id) }
    it { should have_db_index(:question_option_id) }
    it { should have_db_index(:user_id) }
  end
  
  describe "validation" do
    it { should validate_presence_of(:question_option) }
    it { should validate_presence_of(:user) }
    it { should_not allow_mass_assignment_of(:question_option) }
  end
  
  describe "alias" do
    before do
      @answer = FactoryGirl.create(:answer)
    end
    
    it "should respond to option has question_option get/set method" do
      @answer.should respond_to(:option)
      @answer.should respond_to(:option=)
      @answer.option.should be(@answer.question_option)
    end
  end
end
