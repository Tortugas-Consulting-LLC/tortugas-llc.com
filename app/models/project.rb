class Project < ActiveRecord::Base
  has_many :users, :through => :project_users
end
