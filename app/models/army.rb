class Army < ApplicationRecord
  has_many :units, dependent: :destroy
  has_many :attacker_battles, class_name: 'Battle', foreign_key: 'attacker_id', dependent: :nullify
  has_many :defender_battles, class_name: 'Battle', foreign_key: 'defender_id', dependent: :nullify
end
