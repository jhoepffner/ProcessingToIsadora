import codeanticode.syphon.*;
import oscP5.*;
import netP5.*;
SyphonServer server;
OscP5 oscP5;
NetAddress myRemoteLocation;
PGraphics pg;
float beginX = 20.0;  // Initial x-coordinate
float beginY = 10.0;  // Initial y-coordinate
float endX = 570.0;   // Final x-coordinate
float endY = 320.0;   // Final y-coordinate
float distX;          // X-axis distance to move
float distY;          // Y-axis distance to move
float exponent = 4;   // Determines the curve
float x = 0.0;        // Current x-coordinate
float y = 0.0;        // Current y-coordinate
float step = 0.01;    // Size of each step along the path
float pct = 0.0;      // Percentage traveled (0.0 to 1.0)

int sourisOn = 0;
int posX = 0;
int posXP =0;
int posY = 0;
int posYP =0;
int clearBoard = 0;
int r = 255;
int g = 255;
int b = 255;
int largP = 5;
int flagSouris = 0;

void setup() {
  size(1000, 1000, P3D);
  server = new SyphonServer(this, "Processing Syphon");
  noStroke();
  distX = endX - beginX;
  distY = endY - beginY;
  pg = createGraphics(1000, 1000, P3D);
  oscP5 = new OscP5(this, 12000);
  myRemoteLocation = new NetAddress("127.0.0.1", 1234);
  background(0);
}

void draw() {
  pg.beginDraw();
  pg.fill(0, 2);
  pg.noStroke();
  pg.rect(0, 0, width, height);
  pct += step;
  if (pct < 1.0) {
    x = beginX + (pct * distX);
    y = beginY + (pow(pct, exponent) * distY);
  }
  pg.fill(255);
  pg.ellipse(x, y, 20, 20);
  if (clearBoard == 1) {
    pg.background(0);
  }
   pg.endDraw();
  image(pg, 1000, 1000);
  server.sendImage(pg);
}

void mousePressed() {
  pct = 0.0;
  beginX = x;
  beginY = y;
  endX = mouseX;
  endY = mouseY;
  distX = endX - beginX;
  distY = endY - beginY;
}

void oscEvent(OscMessage theOscMessage) {
  /* check if theOscMessage has the address pattern we are looking for. */
  if (theOscMessage.checkAddrPattern("/sourisOn")==true) {
    float sourisOnf = theOscMessage.get(0).floatValue();
    sourisOn = int (sourisOnf);
    return;
  } 
  if (theOscMessage.checkAddrPattern("/posX")==true) {
    float posXf = theOscMessage.get(0).floatValue();
    posX = int (posXf);
    return;
  } 
  if (theOscMessage.checkAddrPattern("/posY")==true) {
    float posYf = theOscMessage.get(0).floatValue();
    posY = int (posYf);
    return;
  }
  if (theOscMessage.checkAddrPattern("/clearBoard")==true) {
    float clearBoardf = theOscMessage.get(0).floatValue();
    clearBoard = int (clearBoardf);
    return;
  }
  if (theOscMessage.checkAddrPattern("/r")==true) {
    float rf = theOscMessage.get(0).floatValue();
    r = int (rf);
    return;
  }
  if (theOscMessage.checkAddrPattern("/g")==true) {
    float gf = theOscMessage.get(0).floatValue();
    g = int (gf);
    return;
  }
  if (theOscMessage.checkAddrPattern("/b")==true) {
    float bf = theOscMessage.get(0).floatValue();
    b = int (bf);
    return;
  }
  if (theOscMessage.checkAddrPattern("/largP")==true) {
    float largPf = theOscMessage.get(0).floatValue();
    largP = int (largPf);
    return;
  }
}

