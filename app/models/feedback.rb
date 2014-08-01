class Feedback < ActiveRecord::Base
attr_accessible :feedback, :email
validates_presence_of :feedback
validates_presence_of :email
end
