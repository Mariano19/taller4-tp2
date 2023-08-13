class Caratula {
  float anchoOrbita = 700;
  float altoOrbita = 700;
  float r = 0;
  int timeOut = 2000;
  
  // orbit declarations
  float posX, posY;
  float radiusX, radiusY;
  float vel;


  Caratula() {
    // Initial values
    posX = posY = 0;
    vel = 0;
    radiusX = 350; // Orbit width
    radiusY = 350; // Orbit height
    
    //imageMode(CENTER);
  }
  
  void actualizar() {
    display();
    transition();
  }
  
  void display() {    
    background(0);
    drawOrbitAnimation();
    //Text
    pushStyle();
    fill(255);
    stroke(255);
    textAlign(CENTER, CENTER);
    textFont(montserratBold);
    textSize(70);
    text("TP 2", width/2, height/2-40);
    textSize(22);
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
    //imageMode(CORNER);
    translate(width/2, height/2);
    // Moving object
    posX = radiusX * cos( vel );
    posY = radiusY * sin( vel );
    
    fill(0);
    stroke(255);
    rotate(radians(frameCount/2)); 
    ellipse( posX, posY, 25, 25 );
    popStyle();
    popMatrix();
  }
  
  void transition() {
    if(millis() > timeOut){
      programa.estado="menu";
    }
    
  }

}
