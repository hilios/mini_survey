class UserWatchesSurveysController < ApplicationController
  # GET /user_watches_surveys
  # GET /user_watches_surveys.json
  def index
    @user_watches_surveys = UserWatchesSurvey.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @user_watches_surveys }
    end
  end

  # GET /user_watches_surveys/1
  # GET /user_watches_surveys/1.json
  def show
    @user_watches_survey = UserWatchesSurvey.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @user_watches_survey }
    end
  end

  # GET /user_watches_surveys/new
  # GET /user_watches_surveys/new.json
  def new
    @user_watches_survey = UserWatchesSurvey.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @user_watches_survey }
    end
  end

  # GET /user_watches_surveys/1/edit
  def edit
    @user_watches_survey = UserWatchesSurvey.find(params[:id])
  end

  # POST /user_watches_surveys
  # POST /user_watches_surveys.json
  def create
    @user_watches_survey = UserWatchesSurvey.new(params[:user_watches_survey])

    respond_to do |format|
      if @user_watches_survey.save
        format.html { redirect_to @user_watches_survey, :notice => 'User watches survey was successfully created.' }
        format.json { render :json => @user_watches_survey, :status => :created, :location => @user_watches_survey }
      else
        format.html { render :action => "new" }
        format.json { render :json => @user_watches_survey.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /user_watches_surveys/1
  # PUT /user_watches_surveys/1.json
  def update
    @user_watches_survey = UserWatchesSurvey.find(params[:id])

    respond_to do |format|
      if @user_watches_survey.update_attributes(params[:user_watches_survey])
        format.html { redirect_to @user_watches_survey, :notice => 'User watches survey was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @user_watches_survey.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /user_watches_surveys/1
  # DELETE /user_watches_surveys/1.json
  def destroy
    @user_watches_survey = UserWatchesSurvey.find(params[:id])
    @user_watches_survey.destroy

    respond_to do |format|
      format.html { redirect_to user_watches_surveys_url }
      format.json { head :ok }
    end
  end
end
