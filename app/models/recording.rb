class Recording < ActiveRecord::Base

  belongs_to :recordable, polymorphic: true
  validates_presence_of :recordable
  
end
