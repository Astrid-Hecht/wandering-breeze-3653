class Contestant < ApplicationRecord
  validates_presence_of :name, :age, :hometown, :years_of_experience
  has_many :contestant_projects
  has_many :projects, through: :contestant_projects

  def show_proj
    projects.where('contestant_projects.contestant_id = ?', self.id)
  end
end