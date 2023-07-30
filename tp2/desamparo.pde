class Desamparo {
  int anchoPersonaje = 55;
  int altoPersonaje = 60;
  //Num stars
  int numStars = 5;
  int anchoEstrella = 100;
  int altoEstrella = 100;

  boolean[] collision = new boolean[numStars];  
  float[] speed = new float[numStars];
  float x, y;
  //boolean collision = false;

  int radioOrbita = 200; // Radio de la órbita
  float anchoOrbita = 400;
  float altoOrbita = 400;
  float r = 0;
  
  // orbit declarations
  float radiusX, radiusY;
  float vel;
  
  boolean allowRotate = false;
  PGraphics pg;
  PGraphics pgEstrella;
  
  

  Desamparo() {
    // Initial values
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
    dibujarOrbitaCentro();
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
    //image(pg, posX-anchoPersonaje/2, posY-altoPersonaje/2, anchoPersonaje, altoPersonaje);


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
  
  void dibujarOrbitaCentro(){
      pushMatrix();
      translate(width / 2, height / 2); // Colocar el origen en el centro de la ventana
    
      // Dibujar la órbita menor
      noFill();
      stroke(255);
      ellipse(0, 0, radioOrbita * 2, radioOrbita * 2);
    
      // Obtener la posición del mouse con respecto al centro de la pantalla
      float mouseXOffset = mouseX - width / 2;
      float mouseYOffset = mouseY - height / 2;
    
      // Calcular el ángulo entre el centro de la pantalla y la posición del mouse
      float mouseAngle = atan2(mouseYOffset, mouseXOffset);
    
      // Calcular posición de la elipse de la línea 20 en función del ángulo y el radio de la órbita
      x = radioOrbita * cos(mouseAngle);
      y = radioOrbita * sin(mouseAngle);
    
      // Dibujar la elipse de la línea 20 en su posición calculada
      stroke(255);
      fill(0); // Color del círculo
      ellipseMode(CENTER); // El círculo se dibuja desde su centro
      //ellipse(x, y, 50, 50); // Dibujar el círculo
      image(pg, x, y, anchoPersonaje, altoPersonaje);
      
      popMatrix();
    }
  
  boolean computeCollision(float localX, float localY) {
    float dist = dist(x-anchoEstrella/2, y-altoEstrella/2,localX,localY );
    if (dist < 75) {      
      // text("collision true" ,0,50);
      return true;
    } else {   
    // text("collision false" ,5,60);
    return false;
    }
  }
  
  void reset() {
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
    popStyle();
  }

  void click() {
  }
}
