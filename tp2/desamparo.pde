class Desamparo {
  int anchoPersonaje = 60;
  int altoPersonaje = 60;

  float anchoOrbita = 500;
  float altoOrbita = 500;
  float r = 0;
  
  // orbit declarations
  float posX, posY;
  float radiusX, radiusY;
  float vel;
  
  boolean allowRotate = false;
  PGraphics pg;
  
  

  Desamparo() {
    // Initial values
    posX = posY = 0;
    vel = 0;
    radiusX = 200; // Orbit width
    radiusY = 200; // Orbit height
    pg = createGraphics(anchoPersonaje, altoPersonaje); //PGraphics for the main element to allow self rotation
  }

  void actualizar() {
    //Standarts values
    debug();    
    fill(255, 0, 0);
    text("DESAMPARO", width/2, 10);

    //Órbit
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
    
  
    pg.beginDraw();
    pg.background(0, 0);
    pg.imageMode(CENTER);
    pg.translate(anchoPersonaje/2, altoPersonaje/2);
    pg.rotate(radians(frameCount/2));    
    pg.image(personaje, 0, 0, anchoPersonaje, altoPersonaje);   
    pg.endDraw();
   
    //Render main element
    //ellipse( posX, posY, 10, 10 );   
    image(pg, posX-anchoPersonaje/2, posY-altoPersonaje/2, anchoPersonaje, altoPersonaje);
    
    
    
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
