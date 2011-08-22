require 'spec_helper'

describe User do
  describe "database" do
    it { should have_db_column(:name).of_type(:string) }
    it { should have_db_column(:email).of_type(:string) }
    it { should have_db_column(:password_digest).of_type(:string) }
    it { should have_db_column(:last_login).of_type(:datetime) }
    it { should have_db_column(:avatar).of_type(:string) }
    it { should have_db_index(:email) }
    it { should have_many(:surveys) }
    it { should have_many(:answers) }
    it { should have_many(:watches) }
    it { should have_and_belong_to_many(:watched_surveys) }
  end
  
  describe "validations" do
    subject { FactoryGirl.create(:user) }
    
    it { should be_valid }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should allow_value('name@server.com').for(:email) }
    it { should_not allow_value('name').for(:email) }
    it { should_not allow_value('name@server.').for(:email) }
    it { should_not allow_value('@server.com').for(:email) }
    it { should_not allow_value('name(at)server.com').for(:email) }
    it { should_not allow_value('name@server(dot)com').for(:email) }    
    it { should allow_mass_assignment_of(:password) }
    it { should allow_mass_assignment_of(:password_confirmation) }
    it { should_not allow_mass_assignment_of(:last_login) }
    it { should_not allow_mass_assignment_of(:password_digest) }
    it { should ensure_length_of(:password).is_at_least(3) }
    
    context "password confirmation" do
      before do
        @user = FactoryGirl.build(:user)
      end
  
      it "should not be valid with wrong password confirmation" do
        @user.password_confirmation = "wrong"
        @user.should_not be_valid
      end
      
      it "should check presence of when password is setted" do
        @user.save!
        user = User.find(@user.id)
        user.password_confirmation.should be_nil
        user.password = '123'
        user.should validate_presence_of(:password_confirmation)
      end
    end
    
    context "on create" do
      subject { FactoryGirl.build(:user) }
      
      it { should validate_presence_of(:password) }
    end
  end
  
  describe "authentication" do
    before(:each) do
      @user = FactoryGirl.create(:user)
    end
    
    it "should have the authenticate method" do
      @user.respond_to?(:authenticate).should be_true
    end
    
    it "should return true when a good password is sent" do
      @user.authenticate(@user.password).should be_true
    end
    
    it "should return false when a bad password is sent" do
      @user.authenticate('wrong').should be_false
    end
    
    it "should update the last_login attribute when authenticate is true" do
      current_date = Time.now
      @user.authenticate(@user.password).should be_true
      @user.last_login.gmt_offset.should == current_date.gmt_offset
    end
  end
  
  describe "avatar" do
    it "should be an instance of avatar uploader" do
      user = FactoryGirl.create(:user)
      user.avatar.instance_of?(AvatarUploader).should be_true
    end
  end
  
  describe "scopes" do
    it "should find all users that answerd an survey" do
      FactoryGirl.create_list(:survey, 5)
      total = 0
      survey = FactoryGirl.create(:survey)
      questions = FactoryGirl.create_list(:question, 5, :survey => survey)
      questions.each do |question|
        choices = FactoryGirl.create_list(:choice, 5, :question => question)
        choices.each_with_index do |choice, i|
          FactoryGirl.create_list(:answer, i, :choice => choice)
          total += i
        end
      end
      User.that_answered_survey(survey).count == total
    end
  end
  
  describe "nested attrbutes" do
    it "should nest answers" do
      user = FactoryGirl.create(:user)
      user.answers_attributes = [
        {:choice => FactoryGirl.create(:choice)},
        {:choice => FactoryGirl.create(:choice)}
      ]
      user.save!
      user.answers.count.should be(2)
    end
    it "should nest watched surveys and return them from habtm relation" do
      user = FactoryGirl.create(:user)
      user.watches_attributes = [
        {:survey => FactoryGirl.create(:survey)},
        {:survey => FactoryGirl.create(:survey)},
        {:survey => FactoryGirl.create(:survey)}
      ]
      user.save!
      user.watches.count.should be(3)
      user.watched_surveys.count.should be(3)
      user.watched_surveys.first.is_a?(Survey).should be_true
    end
  end
end
