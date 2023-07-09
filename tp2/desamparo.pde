class Desamparo {
  float anchoPersonaje = 55;
  float altoPersonaje = 61;

  float anchoOrbita = 500;
  float altoOrbita = 500;
  float r = 0;
  
  // orbit declarations
  float posX, posY;
  float radiusX, radiusY;
  float vel;
  
  boolean allowRotate = false;

  Desamparo() {
    // Initial values
    posX = posY = 0;
    vel = 0;
    radiusX = 200; // Orbit width
    radiusY = 200; // Orbit height
  }

  void actualizar() {
    debug();
    
    fill(255, 0, 0);
    text("DESAMPARO", width/2, 10);

    //Órbita menor
    pushStyle();
    noFill();
    stroke(255);
    ellipse(width/2, height/2, 400, 400);
    popStyle();

    //Órbita mayor
    pushStyle();
    pushMatrix();
    

    // Moving object
    posX = radiusX * cos( vel );
    posY = radiusY * sin( vel );
      
    translate(width/2, height/2);
    
    // rotate(radians(frameCount));

    // Dibujar la imagen
    fill( 255 );
    ellipse( posX, posY, 10, 10 );
    imageMode(CENTER);
    //image(personaje, posX, posY, anchoPersonaje, altoPersonaje);    
    //image(orbitaVanidad, 0, 0, anchoOrbita, altoOrbita); // Cambia las dimensiones de acuerdo a tus necesidades
    popStyle();
    popMatrix();
    
    // Logic left and right
    if (mousePressed) {
      if (mouseButton == LEFT){
        vel += 0.01;
      }
      if (mouseButton == RIGHT){
        vel -= 0.01;
      }
      //r += 1;   
      //allowRotate = true;
      //anchoOrbita = anchoOrbita*1.01;
      //altoOrbita=altoOrbita*1.01;
    } else {
      //allowRotate = false;
    }
    
    
  }
  
  void debug(){
    pushStyle();
    textSize(10);
    textAlign(LEFT,CENTER);
    fill(255,0,0);
    text("anchoPersonaje= "+anchoPersonaje,5,5);
    popStyle();
  }

  void click() {
  }
}
