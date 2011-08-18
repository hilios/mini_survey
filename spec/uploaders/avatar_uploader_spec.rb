require 'spec_helper'

describe AvatarUploader do
  def mock_upload(file_name)
    File.open File.join("#{Rails.root}", "spec", "support", "fixtures", file_name)
  end
  
  before do
    AvatarUploader.enable_processing = true 
    @user     = FactoryGirl.create(:user)
    @uploader = AvatarUploader.new(@user, :avatar)
  end
  
  after do
    AvatarUploader.enable_processing = false
  end
  
  describe "process" do
    it "should resize images to fit in a 140x140 pixels image" do
      ["vertical.jpeg", "horizontal.jpg", "horizontal.png", "horizontal.gif"].each do |file_name|
        @uploader.store! mock_upload(file_name)
        @uploader.should have_dimensions(140, 140)
      end
    end
    
    it "should set the filename to the user id" do
      @uploader.store! mock_upload("horizontal.jpg")
      @uploader.filename.should == "#{@user.id}.jpg"
    end
  end
  
  describe "user validations" do
    it "should only accept images" do
      pdf = mock_upload("doc.pdf")
      lambda { @uploader.store! pdf }.should raise_exception
      
      @user.avatar = pdf
      @user.should_not be_valid
    end
  end
end