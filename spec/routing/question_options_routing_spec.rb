require "spec_helper"

describe QuestionOptionsController do
  describe "routing" do

    it "routes to #index" do
      get("/question_options").should route_to("question_options#index")
    end

    it "routes to #new" do
      get("/question_options/new").should route_to("question_options#new")
    end

    it "routes to #show" do
      get("/question_options/1").should route_to("question_options#show", :id => "1")
    end

    it "routes to #edit" do
      get("/question_options/1/edit").should route_to("question_options#edit", :id => "1")
    end

    it "routes to #create" do
      post("/question_options").should route_to("question_options#create")
    end

    it "routes to #update" do
      put("/question_options/1").should route_to("question_options#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/question_options/1").should route_to("question_options#destroy", :id => "1")
    end

  end
end
