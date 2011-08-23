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
    
    it { should be_valid }
    it { should validate_presence_of(:title) }
  end
  
  describe "methods" do
    it "should return the total answers" do
      choice = FactoryGirl.create(:choice)
      answers = FactoryGirl.create_list(:answer, 10, :choice => choice)
      choice.total.should == 10
    end
    
    describe "to_p" do
      it "should return the percentage of the choice" do
        question = FactoryGirl.create(:question)
        choices = FactoryGirl.create_list(:choice, 5, :question => question)
        total = 0.0
        choices.each_with_index do |choice, i|
          FactoryGirl.create_list(:answer, i, :choice => choice)
          total += i
        end
        choices.each_with_index do |choice, i|
          choice.to_p.should == (i / total)
        end
      end

      it "should never divide by zero" do
        question = FactoryGirl.create(:question)
        choices = FactoryGirl.create_list(:choice, 5, :question => question)
        question.total.should == 0
        choices.first.to_p.should == 0.0
      end
    end
  end
end
