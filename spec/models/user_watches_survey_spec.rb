require 'spec_helper'

describe UserWatchesSurvey do
  describe "database" do
    it { should have_db_column(:user_id).of_type(:integer) }
    it { should have_db_column(:survey_id).of_type(:integer) }
    it { should have_db_index(:user_id).unique(false) }
    it { should have_db_index(:survey_id).unique(false) }
  end
end
