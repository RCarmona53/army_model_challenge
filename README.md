# Army Model (Rails Exercise)

This project is a exercise in army modeling using Ruby on Rails.
The goal is to represent different types of units (pikemen, archers, and knights), their transformations and training, as well as battles between armies.

How I tested
a = Army.create!(civilization: 'Chinese')
b = Army.create!(civilization: 'English')

p = a.units.find_by(type: 'Pikeman')
a.train_unit!(p.id)

arch = b.units.find_by(type: 'Archer')
b.transform_unit!(arch.id)

result = a.attack(b)
