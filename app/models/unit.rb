class Unit < ApplicationRecord
  belongs_to :army

  def years_of_life
    ((Time.current - created_at) / 1.year).to_i
  end

  def base_points
    raise NotImplementedError
  end

  def total_points
    base_points + extra_points.to_i
  end

  def training_info
    raise NotImplementedError
  end

  def transform_info
    raise NotImplementedError
  end

  def train!(payer)
    points_gain, cost = training_info
    payer.spend!(cost)
    update!(extra_points: extra_points.to_i + points_gain)
  end

  def transform!(payer)
    target_class, cost = transform_info
    raise "#{self.class.name} cannot be transformed" if target_class.nil?
    payer.spend!(cost)
    new_unit = target_class.new
    new_unit.extra_points = extra_points
    new_unit
  end
end
