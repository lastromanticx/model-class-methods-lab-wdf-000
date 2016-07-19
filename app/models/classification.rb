class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    all
  end

  def self.longest
    id = Boat.all.order("length DESC").limit(1)[0].id
    Boat.find(id).classifications
  end
end
