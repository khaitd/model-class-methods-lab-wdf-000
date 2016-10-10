class Captain < ActiveRecord::Base
  has_many :boats
  has_many :classifications, through: :boats



  def self.catamaran_operators
    includes(boats: :classifications).where('classifications.name' => 'Catamaran')
  end

  def self.sailors
    includes(boats: :classifications).where('classifications.name' => 'Sailboat').uniq
  end

  def self.motorboats
    includes(boats: :classifications).where('classifications.name' => 'Motorboat').uniq
  end

  def self.talented_seamen
    self.sailors.where(id: self.motorboats.pluck(:id))
  end

  def self.non_sailors
    where.not(id: self.sailors.ids)
  end

end
