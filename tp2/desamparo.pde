class Desamparo {
  float anchoPersonaje = 60;
  float altoPersonaje = 60;

  float anchoOrbita = 500;
  float altoOrbita = 500;
  float r = 0;
  
  // orbit declarations
  float posX, posY;
  float radiusX, radiusY;
  float vel;
  
  boolean allowRotate = false;
  //PGraphics pg;
  
  

  Desamparo() {
    // Initial values
    posX = posY = 0;
    vel = 0;
    radiusX = 200; // Orbit width
    radiusY = 200; // Orbit height
    //pg = createGraphics(60, 60);
  }

  void actualizar() {
    //Standarts values
    debug();    
    fill(255, 0, 0);
    text("DESAMPARO", width/2, 10);

    //Órbita menor
    pushStyle();
    noFill();
    stroke(255);
    ellipse(width/2, height/2, 400, 400);
    popStyle();

    // global translation to center
    imageMode(CORNER);
    translate(width/2, height/2);

    // Moving object
    posX = radiusX * cos( vel );
    posY = radiusY * sin( vel );
    

    // Dibujar la imagen
    fill( 255 );
    //ellipse( posX, posY, 10, 10 );
    //pg.beginDraw();
    //pg.imageMode(CENTER);
    //pg.translate(30, 30);
    //pg.rotate(radians(frameCount));    
    //pg.image(personaje, 30, 0, anchoPersonaje, altoPersonaje);   
    //pg.endDraw();
    
    //image(pg, width/2, height/2);
    image(personaje, posX-anchoPersonaje/2, posY-altoPersonaje/2, anchoPersonaje, altoPersonaje);
    
    
    
    pushStyle();
    pushMatrix();
    //rotate(radians(frameCount));
    
    //image(personaje, posX-anchoPersonaje/2, posY-altoPersonaje/2, anchoPersonaje, altoPersonaje);
    //image(personaje, 0-anchoPersonaje/2, 0-altoPersonaje/2, anchoPersonaje, altoPersonaje);    
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
