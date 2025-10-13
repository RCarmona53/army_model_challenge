class Pikeman < Unit
  def base_points; 5; end
  def training_info; [3, 10]; end
  def transform_info; [Archer, 30]; end
end
