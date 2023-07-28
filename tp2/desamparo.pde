class Desamparo {
  int anchoPersonaje = 60;
  int altoPersonaje = 60;
  //Num stars
  int numStars = 5;
  //float velExt = 0;

  boolean[] collision = new boolean[numStars];  
  float[] speed = new float[numStars];
  //boolean collision = false;

  float anchoOrbita = 500;
  float altoOrbita = 500;
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
    pgEstrella = createGraphics(anchoPersonaje, altoPersonaje);
    
    //Init stars values
    for (int i=0; i<numStars; i++) {
      collision[i] = false;  
      speed[i] = random(0.5 , 2);
    }
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
    
  
    //PG personaje
    pg.beginDraw();
    pg.background(0, 0);
    pg.imageMode(CENTER);
    pg.translate(anchoPersonaje/2, altoPersonaje/2);
    pg.rotate(radians(frameCount/2));    
    pg.image(personaje, 0, 0, anchoPersonaje, altoPersonaje);   
    pg.endDraw();
    
    //PG estrella
    pgEstrella.beginDraw();
    pgEstrella.background(0, 0);
    pgEstrella.imageMode(CENTER);
    pgEstrella.translate(anchoPersonaje/2, altoPersonaje/2);
    pgEstrella.rotate(radians(frameCount/2));    
    pgEstrella.image(estrella, 0, 0, anchoPersonaje, altoPersonaje);   
    pgEstrella.endDraw();
   
    //Render main element
    //ellipse( posX, posY, 10, 10 );   
    image(pg, posX-anchoPersonaje/2, posY-altoPersonaje/2, anchoPersonaje, altoPersonaje);
    
    //
    pushStyle();
    imageMode(CENTER);
    
    //image(pgEstrella, -134 - velExt , 147 + velExt, anchoPersonaje, altoPersonaje);
    //image(pgEstrella, radiusX * cos( 3 ) , radiusY * sin( 3 ), anchoPersonaje, altoPersonaje);

    popStyle();
    
    for (int i=0; i<numStars; i++) {
      float localX = radiusX * cos( i ) -anchoPersonaje/2;
      float localY = radiusY * sin( i ) - altoPersonaje/2;      
      float velExt = 0;
      move();

      //float newPos = lerp(localX, random(0, 360),random(0.2, 0.8));
      
      
      if (!computeCollision(localX, localY) && !collision[i]) {
        velExt = 0;
        speed[i] = 0;
        image(pgEstrella, localX , localY, anchoPersonaje, altoPersonaje);
      } else {
        velExt++;
        //image(pgEstrella, localX+speed  , localY, anchoPersonaje, altoPersonaje);
      }
      if (computeCollision(localX, localY) || collision[i]) {
        collision[i] = true;
        
        image(pgEstrella, localX+speed[i]  , localY, anchoPersonaje, altoPersonaje);
      }
      println("entro dist", velExt);
      
      
    }

    //speed++;
    for (int i=0; i<numStars; i++) {
      //speed[i] += random(-2 , 2);
    }
    speed[0] +=2;
    speed[1] +=1;
    speed[2] -=2;
    
    //float dist = dist(radiusX * cos( 1 ) -anchoPersonaje/2 , radiusY * sin( 1 ) - altoPersonaje/2, posX, posY);
    
    
    
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
    //velExt++;
    //speed++;
    //Logic collide
    //float dist = dist(posX-anchoPersonaje/2, posY-altoPersonaje/2,)
  }
  
  boolean computeCollision(float localX, float localY) {
    float dist = dist(posX-anchoPersonaje/2, posY-altoPersonaje/2,localX,localY );
    if (dist < 50) {      
      text("collision true" ,0,50);
      return true;
    } else {   
    text("collision false" ,5,60);
    return false;
    }
  }
  
  void move() {
    //velExt++;
    //y = y + y;
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
