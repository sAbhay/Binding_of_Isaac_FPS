class Outline // outline for stat-changing items
{
  public int statSelect;
  public float change;
  public String name;
  public int secondary;
  public float secondaryChange;
  
  Outline(String _name, int _statSelect, float _changeValue, int _secondary, float _secondaryChange)
  {
    name = _name;
    
    statSelect = _statSelect;
    change = _changeValue;
    
    secondary = _secondary;
    secondaryChange = _secondaryChange;
  }
}