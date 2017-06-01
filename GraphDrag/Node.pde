class Node
{
  final static float R = 20;
  
  final int id;
  float x, y;
  
  boolean pinned = false;
  
  boolean selected = false;
  boolean highlighted = false;
  boolean dummy = false;
  
  
  public Node(int id, float x, float y)
  {
    this.id = id;
    this.x = x;
    this.y = y;
  }
  
  public Node(JSONObject json)
  {
    this(json.getInt("id"), json.getFloat("x"), json.getFloat("y"));
  }
  
  JSONObject toJSON()
  {
    JSONObject ret = new JSONObject();
    ret.setInt("id", id);
    ret.setFloat("x", x);
    ret.setFloat("y", y);
    return ret;
  }
  
  boolean isNear(float x, float y)
  {
    return dist(x, y, this.x, this.y) < R;
  }
  
  void drawOn(PGraphics g)
  {
    if (dummy) return;
    g.pushMatrix();
    g.translate(x, y);
    g.stroke(120);
    g.strokeWeight(1);
    int b = isNear(mouseX, mouseY) ? 70 : 40;
    color c = color(b + (pinned ? 160 : 0), b, b + (selected ? 50 : 0));
    g.fill(c);
    g.ellipse(0, 0, 2*R, 2*R);
    g.popMatrix();
  }
  
}