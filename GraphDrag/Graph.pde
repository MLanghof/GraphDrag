import java.util.List;

class Graph
{
  HashMap<Integer, Node> nodes = new HashMap<Integer, Node>();
  ArrayList<Edge> edges = new ArrayList<Edge>();
  
  public Graph()
  {
  }
  
  public Graph(JSONObject json)
  {
    nodesFromJSON(json.getJSONArray("nodes"));
    edgesFromJSON(json.getJSONArray("edges"));
  }
  
  void nodesFromJSON(JSONArray json)
  {
    for (int i = 0; i < json.size(); i++)
    {
      Node node = new Node(json.getJSONObject(i));
      nodes.put(node.id, node);
    }
  }
  
  void edgesFromJSON(JSONArray json)
  {
    for (int i = 0; i < json.size(); i++)
    {
      Edge edge = new Edge(json.getJSONObject(i), nodes);
      edges.add(edge);
    }
  }
  
  JSONObject toJSON()
  {
    JSONObject ret = new JSONObject();
    ret.setJSONArray("nodes", getNodeJSON());
    ret.setJSONArray("edges", getEdgeJSON());
    return ret;
  }
  
  JSONArray getNodeJSON()
  {
    JSONArray ret = new JSONArray();
    for (int i = 0; i < nodes.size(); i++)
    {
      ret.setJSONObject(i, nodes.get(i).toJSON());
    }
    return ret;
  }
  
  JSONArray getEdgeJSON()
  {
    JSONArray ret = new JSONArray();
    for (int i = 0; i < edges.size(); i++)
    {
      ret.setJSONObject(i, edges.get(i).toJSON());
    }
    return ret;
  }
  
  // Returns a new node with a valid ID that is added to the graph.
  Node newNode()
  {
    int newId = 0;
    while (nodes.containsKey(newId)) newId++;
    Node node = new Node(newId, 0, 0);
    nodes.put(node.id, node);
    return node;
  }
  
  void deleteSelectedNodes()
  {
    java.util.Iterator<Node> iter = nodes.values().iterator();
    while (iter.hasNext())
    {
      Node node = iter.next();
      if (node.selected) {
        removeIncidentEdges(node);
        iter.remove();
      }
    }
  }
  
  void removeNode(Node node)
  {
    removeIncidentEdges(node);
    nodes.remove(node.id);
  }
  
  void removeIncidentEdges(Node node)
  {
    java.util.Iterator<Edge> iter = edges.iterator();
    while (iter.hasNext())
    {
      Edge edge = iter.next();
      if (edge.n1 == node || edge.n2 == node)
        iter.remove();
    }
  }
  
  Node nodeNear(float x, float y)
  {
    return nodeNear(x, y, null);
  }
  
  Node nodeNear(float x, float y, Node ignore)
  {
    Node ret = null;
    for (Node node : nodes.values()) {
      node.highlighted = false;
      if (node.isNear(x, y) && node != ignore)
        ret = node;
    }
    return ret;
  }
  
  void clickedAt(float x, float y)
  {
    Node clickedNode = nodeNear(x, y);
    if (clickedNode == null)
      return;
    
    clickedNode.selected = !clickedNode.selected;
  }
  
  void highlightAt(float x, float y)
  {
    Node clickedNode = nodeNear(x, y);
    if (clickedNode == null)
      return;
    
    clickedNode.highlighted = true;
  }
  
  void drawOn(PGraphics g)
  {
    drawEdgesOn(g);
    drawNodesOn(g);
  }
  
  void drawEdgesOn(PGraphics g)
  {
    for (Edge edge : edges) {
      edge.drawOn(g);
    }
  }
  
  void drawNodesOn(PGraphics g)
  {
    for (Node node : nodes.values()) {
      node.drawOn(g);
    }
  }
}