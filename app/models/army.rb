class Army < ApplicationRecord
  has_many :units, dependent: :destroy
  has_many :attacker_battles, class_name: 'Battle', foreign_key: 'attacker_id', dependent: :nullify
  has_many :defender_battles, class_name: 'Battle', foreign_key: 'defender_id', dependent: :nullify

  STARTING_COUNTS = {
    'Chinese'   => { pikemen: 2, archers: 25, knights: 2 },
    'English'   => { pikemen: 10, archers: 10, knights: 10 },
    'Byzantine' => { pikemen: 5, archers: 8,  knights: 15 }
  }.freeze

  WIN_REWARD = 100

  validates :civilization, presence: true
  after_create :populate_initial_units

  def total_points
    units.sum(&:total_points)
  end

  def spend!(amount)
    raise "Not enough gold" if gold < amount
    update!(gold: gold - amount)
  end

  def receive!(amount)
    update!(gold: gold + amount)
  end

  def train_unit!(unit_or_id)
    unit = units.find(unit_or_id)
    unit.train!(self)
  end

  def transform_unit!(unit_or_id)
    unit = units.find(unit_or_id)
    new_unit = unit.transform!(self)
    unit.destroy!
    units.create!(type: new_unit.type, extra_points: new_unit.extra_points, created_at: new_unit.created_at, updated_at: new_unit.created_at)
  end

  def attack(opponent)
    own_pts = total_points
    opp_pts = opponent.total_points
    now = Time.current

    if own_pts > opp_pts
      result = :win
      opponent.remove_top_units!(2)
      self.receive!(WIN_REWARD)
    elsif own_pts < opp_pts
      result = :loss
      self.remove_top_units!(2)
      opponent.receive!(WIN_REWARD)
    else
      result = :tie
      self.remove_top_units!(1)
      opponent.remove_top_units!(1)
    end

    Battle.create!(
      attacker: self,
      defender: opponent,
      result: result.to_s,
      attacker_points: own_pts,
      defender_points: opp_pts,
      occurred_at: now
    )
    result
  end

  def remove_top_units!(n)
    return if n <= 0
    top = units.to_a.sort_by { |u| -u.total_points }.take(n)
    top.each(&:destroy)
  end

  private

  def populate_initial_units
    counts = STARTING_COUNTS[civilization] || { pikemen: 0, archers: 0, knights: 0 }
    counts[:pikemen].times { units.create!(type: 'Pikeman') }
    counts[:archers].times  { units.create!(type: 'Archer') }
    counts[:knights].times  { units.create!(type: 'Knight') }
  end
end
