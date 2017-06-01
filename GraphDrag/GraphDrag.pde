


String graphJsonFile = "graph.json";
String graphJsonOutFile = "graphOut.json";

Graph graph;

boolean graphEditMode = true;

Node draggedNode;
Edge draggedEdge;


void setup()
{
  size(800, 800);
  
  //loadGraph(graphJsonFile);
  graph = new Graph();
}

void draw()
{
  background(30);
  graph.drawOn(g);
}

void loadGraph(String filename)
{
  JSONObject graphJson = loadJSONObject(filename);
  graph = new Graph(graphJson);
}

void saveGraph(String filename)
{
  JSONObject graphJson = graph.toJSON();
  saveJSONObject(graphJson, filename);
}

void keyPressed()
{
  switch (key)
  {
    case 's': saveGraph(graphJsonOutFile); break;
    case 'l': loadGraph(graphJsonFile); break;
  }
  if (keyCode == DELETE)
    graph.deleteSelectedNodes();
}

void mousePressed()
{
  if (graphEditMode)
  {
    Node clickedNode = graph.nodeNear(mouseX, mouseY);
    if (mouseButton == LEFT)
    {
      draggedNode = clickedNode;
      if (draggedNode == null)
      {
        draggedNode = graph.newNode();
        draggedNode.x = mouseX;
        draggedNode.y = mouseY;
      }
    }
    else {
      if (clickedNode == null) return;
      draggedNode = graph.newNode();
      draggedNode.x = mouseX;
      draggedNode.y = mouseY;
      draggedNode.dummy = true;
      draggedEdge = new Edge(clickedNode, draggedNode);
      graph.edges.add(draggedEdge);
    }
  }
  else {
  }
}

void mouseDragged()
{
  if (graphEditMode)
  {
    if (draggedNode == null) return;
    
    draggedNode.x = mouseX;
    draggedNode.y = mouseY;
    
    if (draggedEdge != null)
    {
      Node near = graph.nodeNear(mouseX, mouseY, draggedNode);
      if ((near != null) && (near != draggedEdge.n1)) {
        println("asd");
        draggedEdge.n2 = near;
      }
      else {
        draggedEdge.n2 = draggedNode;
      }
    }
  }
}

void mouseReleased()
{
  if (graphEditMode)
  {
    if (draggedEdge != null) {
      if (draggedEdge.n2 != draggedNode) {
        graph.removeNode(draggedNode);
      }
      else {
        draggedNode.dummy = false;
      }
    }
    draggedNode = null;
    draggedEdge = null;
  }
}

void mouseClicked()
{
  graph.clickedAt(mouseX, mouseY);
}

void mouseMoved()
{
  if (mousePressed) return;
  graph.highlightAt(mouseX, mouseY);
}

// Build spanning tree
// 