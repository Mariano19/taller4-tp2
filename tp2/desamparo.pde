class Desamparo {
  int anchoPersonaje = 55;
  int altoPersonaje = 60;
  //Num stars
  int numStars = 5;
  int anchoEstrella = 100;
  int altoEstrella = 100;

  boolean[] collision = new boolean[numStars];  
  float[] speed = new float[numStars];
  //boolean collision = false;

  float anchoOrbita = 400;
  float altoOrbita = 400;
  float r = 0;
  
  // orbit declarations
  float posX, posY;
  float radiusX, radiusY;
  float vel;
  
  boolean allowRotate = false;
  PGraphics pg;
  PGraphics pgEstrella;
  
  

  Desamparo() {
    // Initial values
    posX = posY = 0;
    vel = 0;
    radiusX = 200; // Orbit width
    radiusY = 200; // Orbit height
    pg = createGraphics(anchoPersonaje, altoPersonaje); //PGraphics for the main element to allow self rotation
    pgEstrella = createGraphics(anchoEstrella, altoEstrella);
    
    //Init stars values
    for (int i=0; i<numStars; i++) {
      collision[i] = false;  
      speed[i] = random(0.5 , 2);
    }
  }

  void actualizar() {
    pushStyle();
    pushMatrix();
    
    //Standarts values
    debug();    
    fill(255, 0, 0);
    text("DESAMPARO", width/2, 10);

    //Órbit    
    noFill();
    stroke(255);
    ellipse(width/2, height/2, anchoOrbita, altoOrbita);
    

    // global translation to center
    imageMode(CORNER);
    translate(width/2, height/2);
    

    // Moving object
    posX = radiusX * cos( vel );
    posY = radiusY * sin( vel );
    
  
    //PG personaje
    pg.beginDraw();
    pg.background(0, 0);
    pg.imageMode(CENTER);
    pg.translate(anchoPersonaje/2, altoPersonaje/2);
    // Rotate
    //pg.rotate(radians(frameCount/2));    
    pg.image(personaje, 0, 0, anchoPersonaje, altoPersonaje);   
    pg.endDraw();
    
    //PG estrella
    pgEstrella.beginDraw();
    pgEstrella.background(0, 0);
    pgEstrella.imageMode(CENTER);
    pgEstrella.translate(anchoEstrella/2, altoEstrella/2);
    pgEstrella.rotate(radians(frameCount/2));    
    pgEstrella.image(estrella, 0, 0, anchoEstrella, altoEstrella);   
    pgEstrella.endDraw();
   
    //Render main element
    //ellipse( posX, posY, 10, 10 );   
    image(pg, posX-anchoPersonaje/2, posY-altoPersonaje/2, anchoPersonaje, altoPersonaje);


    //Render stars    
    for (int i=0; i<numStars; i++) {
      float localX = radiusX * cos( i ) -anchoEstrella/2;
      float localY = radiusY * sin( i ) - altoEstrella/2;

      if (!computeCollision(localX, localY) && !collision[i]) {
        speed[i] = 0;
        image(pgEstrella, localX , localY, anchoEstrella, altoEstrella);
      }
      if (computeCollision(localX, localY) || collision[i]) {
        collision[i] = true;
        
        image(pgEstrella, localX+speed[i]  , localY+speed[i], anchoEstrella, altoEstrella);
      }     
    }

    //Speed values
    for (int i=0; i<numStars; i++) {
      //speed[i] += random(-2 , 2);
    }
    speed[0] +=2;
    speed[1] +=1;
    speed[2] +=1;
    speed[3] -=1.5;
    speed[4] -=1;

    // Logic left and right
    if (mousePressed) {
      if (mouseButton == LEFT){
        vel += 0.01;
      }
      if (mouseButton == RIGHT){
        vel -= 0.01;
      }      
    }
    popMatrix();
    popStyle();
  }
  
  boolean computeCollision(float localX, float localY) {
    float dist = dist(posX-anchoEstrella/2, posY-altoEstrella/2,localX,localY );
    if (dist < 75) {      
      // text("collision true" ,0,50);
      return true;
    } else {   
    // text("collision false" ,5,60);
    return false;
    }
  }
  
  void reset() {
    posX = posY = 0;
    vel = 0;
    for (int i=0; i<numStars; i++) {
      collision[i] = false;  
      speed[i] = random(0.5 , 2);
    }
  }
  
  void debug(){
    pushStyle();
    textSize(14);
    textAlign(LEFT,CENTER);
    fill(255,0,0);
    text("anchoPersonaje= "+anchoPersonaje,5,5);
    text("posX" + posX,5,20);
    text("posY" + posY,5,35);
    popStyle();
  }

  void click() {
  }
}
