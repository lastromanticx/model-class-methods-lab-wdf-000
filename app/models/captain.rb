class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    # Boat.joins(:classifications).joins(:captain).where("classifications.name = 'Catamaran'").select("captains.*")

    includes(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    ids = Captain.all.select{|captain| captain.boats.map{|boat| boat.classifications.map{|classification| classification.name}}.flatten.include?("Sailboat")}.map{|captain| captain.id}
    where(id: ids)
  end

  def self.talented_seamen
    ids = Captain.all.select{|captain| (captain.boats.map{|boat| boat.classifications.map{|classification| classification.name}}.flatten & ["Sailboat","Motorboat"]).length == 2}.map(&:id)
    where(id: ids)
  end

  def self.non_sailors
    ids = Captain.all.select{|captain| !captain.boats.map{|boat| boat.classifications.map{|classification| classification.name}}.flatten.include?("Sailboat")}.map(&:id)
    where(id: ids)
  end
end
