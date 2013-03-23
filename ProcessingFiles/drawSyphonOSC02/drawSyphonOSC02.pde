import codeanticode.syphon.*;
import oscP5.*;
import netP5.*;
SyphonServer server;
OscP5 oscP5;
NetAddress myRemoteLocation;
PGraphics pg;
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
  pg = createGraphics(1000, 1000, P3D);
  oscP5 = new OscP5(this, 12000);
  myRemoteLocation = new NetAddress("127.0.0.1", 1234);
  background(0);
}

void draw() {

  pg.beginDraw();
  pg.strokeWeight(largP);
  strokeCap(PROJECT);
  strokeJoin(ROUND);
  pg.stroke(r, g, b);
  pg.smooth(8);

  if (sourisOn == 1) {
    if (flagSouris == 1) {
      pg.line(posX, posY, posXP, posYP);
    }
    else {
      flagSouris = 1;
    }
  }
  else {
    flagSouris = 0;
  }
  posXP = posX;
  posYP = posY;
  if (clearBoard == 1) {
    pg.background(0);
  }
  pg.endDraw();
  image(pg, 1000, 1000);
  server.sendImage(pg);
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

