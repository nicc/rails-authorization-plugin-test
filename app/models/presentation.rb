class Presentation < ActiveRecord::Base
  acts_as_authorizable
  
  belongs_to :user
  belongs_to :owner, :class_name => "User"
  
  always_has :owner
  always_has :creator, :as => :user
end
