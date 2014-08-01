class Feedback < ActiveRecord::Base
attr_accessible :feedback
validates_presence_of :feedback
end
