class Mediacion {
  FWorld mundo;
  
  FBox main, ancla;
  FCircle circles;
  FRevoluteJoint rAncla;
  //FCircle main;
  //float posX, posY;
  int anchoPersonaje = 120;
  int altoPersonaje = 130;
  int sizeEstrella = 150; 
  int radioOrbita = 400; // Radio de la órbita
  //FPoly myBlob = new FPoly();
  
  
  
  Mediacion() {
    personaje.resize(120, 130);
    mundo = new FWorld();
    mundo.setEdges(100);
    mundo.setGravity(0,0);
    //posX = posY = 0;
    //myBlob.vertex(0, 0);
    //myBlob.vertex(-anchoPersonaje/2, altoPersonaje/4);
    //myBlob.vertex(-anchoPersonaje/2, altoPersonaje/1.5);
    //myBlob.vertex(600, 400); 
    //myBlob.setStatic(true);
    
    

    
    
    // Personaje principal
    main = new FBox(anchoPersonaje, altoPersonaje);
    main.setPosition(width/2, height/2);
    main.setStatic(true);
    main.attachImage(personaje);
    
    
    // Anclaje
    ancla = new FBox(10, 10); 
    ancla.setDrawable(false);
    ancla.setPosition(width/2, height/2);
    ancla.setGrabbable(false);
    ancla.setStatic(true);
    
    // Estrella
    circles = new FCircle(sizeEstrella); 
    circles.setPosition(width/2, 150);
    //estrella.setStatic(false);
    //estrella.setFill(50,50,255);
    circles.attachImage(estrella);
    
    // Union
    rAncla = new FRevoluteJoint(ancla, circles);
    //rAncla.setLength();
    rAncla.setEnableMotor(true);
    rAncla.setMotorSpeed(800);
    rAncla.setAnchor(width/2,height/2);
    rAncla.setMaxMotorTorque(10000);
    rAncla.setCollideConnected(true);
    rAncla.setDrawable(false);
    
    
    mundo.add(ancla);
    mundo.add(main);
    mundo.add(circles);
    mundo.add(rAncla);
  }
  
  void actualizar() {
    
    fill(0,0,0,80);
    rect(0,0,width,height);
    //background(255);
    //println("entro mediacion");
    mundo.step();
    mundo.draw();
    mundo.drawDebug();
    dibujarOrbitaCentro();
    
    
  }
  
  void dibujarOrbitaCentro(){
    pushMatrix();
    translate(width / 2, height / 2); // Colocar el origen en el centro de la ventana
  
    // Dibujar la órbita menor
    noFill();
    stroke(255);
    ellipse(0, 0, radioOrbita * 2, radioOrbita * 2);
    popMatrix();
  }
}
