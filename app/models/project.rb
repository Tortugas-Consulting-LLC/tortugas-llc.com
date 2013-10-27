class Project < ActiveRecord::Base
  has_many :users, :through => :projects_users
  has_many :projects_users
  has_many :events

  def balance
    Event.where(project: self).sum('amount')
  end
end
