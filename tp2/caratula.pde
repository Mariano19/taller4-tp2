class Caratula {
  float anchoOrbita = 400;
  float altoOrbita = 400;
  float r = 0;
  int timeOut = 1000;
  
  // orbit declarations
  float posX, posY;
  float radiusX, radiusY;
  float vel;


  Caratula() {
    // Initial values
    posX = posY = 0;
    vel = 0;
    radiusX = 200; // Orbit width
    radiusY = 200; // Orbit height
    
    imageMode(CENTER);
  }
  
  void actualizar() {
    display();
    transition();
  }
  
  void display() {    
    
    drawOrbitAnimation();
    //Text
    pushStyle();
    fill(255);
    stroke(255);
    textAlign(CENTER, CENTER);
    textSize(36);
    text("TP 2", width/2, height/2-15);
    textSize(14);
    text("FLORES, LOAYZA, ORELLANA, PINTO, QUATTROCCHI ", width/2, height/2+15);
    popStyle();
  }
  
  void drawOrbitAnimation() {
    //Órbit
    pushStyle();
    noFill();
    stroke(255);
    ellipse(width/2, height/2, anchoOrbita, altoOrbita);    
    popStyle();
    
    pushStyle();
    pushMatrix();
    imageMode(CORNER);
    translate(width/2, height/2);
    // Moving object
    posX = radiusX * cos( vel );
    posY = radiusY * sin( vel );
    
    fill(0);
    stroke(255);
    rotate(radians(frameCount/2)); 
    ellipse( posX, posY, 15, 15 );
    popStyle();
    popMatrix();
  }
  
  void transition() {
    if(millis() > timeOut){
      programa.estado="menu";
    }
    
  }

}
