require 'spec_helper'

describe ApplicationHelper do
  describe "link_to_remove_fields" do
    it "should render an input and a link with data-nested='remove'" do
      # SimpleForm.new
      # simple_form_for :user do |form|
      #   link = link_to_remove('Remove', form)
      #   link.should match(/_destroy/)
      # end
    end
  end
  
  describe "respond to [:notice, :info, :warning, :error]" do
    [:notice, :info, :warning, :error].each do |key|
      it "should return a formatted p when :#{key.to_s} flash message is present" do
        flash[key] = "some message"
        message = /some message/
        p_tag = Regexp.new(Regexp.escape("<p class=\"flash #{key}\""))
        flash_messages.should match(p_tag)
        flash_messages.should match(message)
      end
    end
  end
  
  describe "controller_is?" do
    before(:each) do
      controller.params[:controller] = "test"
    end
    
    it "should return true or false for controller name(s)" do
      helper.controller_is?('test').should be_true
      helper.controller_is?('fake').should be_false
      helper.controller_is?('fake', 'test').should be_true
      helper.controller_is?('fake', 'mock').should be_false
      # Same test with symbols
      helper.controller_is?(:test).should be_true
      helper.controller_is?(:fake).should be_false
      helper.controller_is?(:fake, :test).should be_true
      helper.controller_is?(:fake, :mock).should be_false
    end
    
    it "should execute block instead of returning true or fale" do
      helper.controller_is?('test') { |b| b.should be_true }
      helper.controller_is?('fake') { |b| b.should be_false }
      helper.controller_is?(:fake, :test) { |b| b.should be_true }
      helper.controller_is?(:fake, :mock) { |b| b.should be_false }
    end
  end
  
  describe "action_is?" do
    before(:each) do
      controller.params[:action] = "test"
    end
    
    it "should return true or false for action name(s)" do
      helper.action_is?('test').should be_true
      helper.action_is?('fake').should be_false
      helper.action_is?('fake', 'test').should be_true
      helper.action_is?('fake', 'mock').should be_false
      # Same test with symbols
      helper.action_is?(:test).should be_true
      helper.action_is?(:fake).should be_false
      helper.action_is?(:fake, :test).should be_true
      helper.action_is?(:fake, :mock).should be_false
    end
    
    it "should execute block instead of returning true or fale" do
      helper.action_is?('test') { |b| b.should be_true }
      helper.action_is?('fake') { |b| b.should be_false }
      helper.action_is?(:fake, :test) { |b| b.should be_true }
      helper.action_is?(:fake, :mock) { |b| b.should be_false }
    end
  end
end