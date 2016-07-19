class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    Boat.joins(:classifications).joins(:captain).where("classifications.name = 'Catamaran'").select("captains.*")
  end
end
