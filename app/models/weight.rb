class Weight < ApplicationRecord
  belongs_to :user
  before_save :convert_to_kilograms
  validates :value, presence: true, numericality: { greater_than: 0 }

  def self.kg_to_lbs(kilograms)
    kilograms * 2.20462
  end

  def self.lbs_to_kg(pounds)
    pounds / 2.20462
  end

  def preferred_value(unit)
    if self.unit == 'kg' && unit == 'lbs'
      puts "Converting to lbs"
      Weight.kg_to_lbs(value)
    elsif self.unit == 'lbs' && unit == 'kg'
      puts "Converting to kg"
      Weight.lbs_to_kg(value)
    else
      value
    end
  end

  private

  def convert_to_kilograms
    if unit == 'lbs'
      self.value = Weight.lbs_to_kg(value)
      self.unit = 'kg'
    end
  end
end
