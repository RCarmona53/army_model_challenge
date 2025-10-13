class Battle < ApplicationRecord
  belongs_to :attacker, class_name: 'Army'
  belongs_to :defender, class_name: 'Army'

  enum result: { win: 'win', loss: 'loss', tie: 'tie' }, _prefix: true
end