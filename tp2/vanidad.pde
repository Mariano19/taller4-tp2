class Vanidad {
  float anchoPersonaje = 120;
  float altoPersonaje = 130;

  float anchoOrbita = 700;
  float altoOrbita = 700;
  
  PGraphics pg;

  Vanidad() {
    
  }

  void actualizar() {
    debug();
    
    fill(255, 0, 0);
    text("VANIDAD", width/2, 10);

    //Órbita menor
    pushStyle();
    noFill();
    stroke(255);
    ellipse(width/2, height/2, 150, 150);
    popStyle();

    //Órbita mayor
    pushStyle();
    pushMatrix();


    // Establecer el origen en el centro de la pantalla
    translate(width/2, height/2);

    // Rotar la imagen
    rotate(radians(frameCount));

    // Dibujar la imagen
    imageMode(CENTER);
    image(orbitaVanidad, 0, 0, anchoOrbita, altoOrbita); // Cambia las dimensiones de acuerdo a tus necesidades
    popStyle();
    popMatrix();


    pushStyle();
    imageMode(CENTER);

 
  
    image(personaje, width/2, height/2, anchoPersonaje, altoPersonaje);
    popStyle();

    if (mousePressed) {
      anchoPersonaje = anchoPersonaje*1.01;
      altoPersonaje=altoPersonaje*1.01;
      
      if(anchoPersonaje>170){
        anchoOrbita = anchoOrbita*1.01;
      altoOrbita=altoOrbita*1.01;
      }
      //anchoOrbita = anchoOrbita*1.01;
      //altoOrbita=altoOrbita*1.01;
    } else {
      if (anchoPersonaje>120 && altoPersonaje>130) {
        anchoPersonaje--;
        altoPersonaje--;
        anchoOrbita--;
        altoOrbita--;
      } else {
        anchoPersonaje = 120;
        altoPersonaje = 130;
        anchoOrbita = 700;
        altoOrbita = 700;
      }
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
