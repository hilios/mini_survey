class Watch < ActiveRecord::Base
  belongs_to :user
  
  belongs_to :survey
  
  validates :user_id,
    :uniqueness => {:scope => :survey_id}
end
