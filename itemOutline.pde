class ItemOutline // outline for stat-changing items
{
  private int statSelect;
  private float change;
  private String name;
  private int secondary;
  private float secondaryChange;
  private int scale;
  
  ItemOutline(String _name, int _scale, int _statSelect, float _changeValue, int _secondary, float _secondaryChange)
  {
    name = _name;
    scale = _scale;
    
    statSelect = _statSelect;
    change = _changeValue;
    
    secondary = _secondary;
    secondaryChange = _secondaryChange;
  }
}