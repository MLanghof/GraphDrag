class Edge
{
  Node n1;
  Node n2;
  
  public Edge(Node n1, Node n2)
  {
    this.n1 = n1;
    this.n2 = n2;
  }
  
  public Edge(JSONObject json, HashMap<Integer, Node> nodes)
  {
    this(nodes.get(json.getInt("n1")), nodes.get(json.getInt("n2")));
  }
  
  JSONObject toJSON()
  {
    JSONObject ret = new JSONObject();
    ret.setInt("n1", n1.id);
    ret.setInt("n2", n2.id);
    return ret;
  }
  
  void drawOn(PGraphics g)
  {
    g.stroke(120);
    g.line(n1.x, n1.y, n2.x, n2.y);
  }
}