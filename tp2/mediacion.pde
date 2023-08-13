class Mediacion {
  FWorld mundo;

  
  FBox main;
  FCircle ancla;
  FCircle[] enemigos = new FCircle[3];
  FCircle[] enemigos2 = new FCircle[3];
  FDistanceJoint cadenaPersonaje;  
  FMouseJoint cadena;
  //ArrayList<FDistanceJoint> cadenas;
  //FRevoluteJoint rAncla;
  float posX, posY;
  int anchoPersonaje = 120;
  int altoPersonaje = 130;
  int sizeEstrella = 140; 
  int radioOrbita = 325; // Radio de la órbita
  int i = 0;
  int y = 0;
  int radioOrbita2 = 385; // Radio de la órbita
  //FPoly myBlob = new FPoly();
  
  
  
  Mediacion() {
    //cadenas = new ArrayList<FDistanceJoint>();
    pushStyle();
    pushMatrix();
    personaje.resize(120, 130);
    mundo = new FWorld();
    mundo.setEdges(100);
    mundo.setGravity(0,0);
    posX = posY = 0;
    
    
    //myBlob.vertex(0, 0);
    //myBlob.vertex(-anchoPersonaje/2, altoPersonaje/4);
    //myBlob.vertex(-anchoPersonaje/2, altoPersonaje/1.5);
    //myBlob.vertex(600, 400); 
    //myBlob.setStatic(true);
    for (FCircle enemigo : enemigos){      
      float localX = radioOrbita * cos( i ) -sizeEstrella/2;      
      float localY = radioOrbita * sin( i ) -sizeEstrella/2;
      float angulo = 1000*i;
      float x = cos(angulo);
      float y = sin(angulo);

      enemigo = new FCircle(sizeEstrella); 
      enemigo.setPosition(width/2, height/2);
      enemigo.attachImage(estrella);
      enemigo.setName("enemigo");
      mundo.add(enemigo);
      
      cadena = new FMouseJoint(enemigo,width/2, height/2);
      cadena.setDrawable(false);
      mundo.add(cadena);
      //cadenas[i].setLength(50);
      //mundo.add(cadenas[i]);
      i++;
    }
    
    for (FCircle enemigo : enemigos2){      
      float localX = radioOrbita * cos( i ) -sizeEstrella/2;      
      float localY = radioOrbita * sin( i ) -sizeEstrella/2;
      float angulo = 1000*i;
      float x = cos(angulo);
      float y = sin(angulo);

      enemigo = new FCircle(sizeEstrella); 
      enemigo.setPosition(width/2, height/2);
      enemigo.attachImage(estrellamala);
      enemigo.setName("enemigo2");
      mundo.add(enemigo);
      
      cadena = new FMouseJoint(enemigo,width/2, height/2);
      cadena.setDrawable(false);
      mundo.add(cadena);
      //cadenas[i].setLength(50);
      //mundo.add(cadenas[i]);
      y++;
    }
    
    
    // Personaje principal
    main = new FBox(anchoPersonaje, altoPersonaje);
    main.setPosition(width/2, height/2);
    main.setStatic(true);
    main.attachImage(personaje);
    
    
    // Anclaje
    ancla = new FCircle(radioOrbita*2); 
    ancla.setDrawable(false);
    ancla.setPosition(width/2, height/2);
    ancla.setGrabbable(false);
    ancla.setStatic(true);
    
    // Estrella
    //enemigos = new FCircle(sizeEstrella); 
    //enemigos.setPosition(posX, posY);
    //estrella.setStatic(false);
    //estrella.setFill(50,50,255);
    //enemigos.attachImage(estrella);
    //circles.addForce(1000,10);
    
    //cadena personaje
    cadenaPersonaje = new FDistanceJoint(main, ancla);
    cadenaPersonaje.setLength(50);
    cadenaPersonaje.setFrequency(50000);
    cadenaPersonaje.setDrawable(false);
    
    mundo.add(ancla);
    mundo.add(main);
    mundo.add(cadenaPersonaje);

    popMatrix();
    popStyle();
  }
  
  void actualizar() {
    limitePersonaje();
    fill(0,0,0,80);
    rect(0,0,width,height);
    //background(255);
    //println("entro mediacion");
    
    //mundo.drawDebug();
    mundo.step();
    mundo.draw();
    
    dibujarOrbitaCentro();    
    movimientoEstrellas();
    
    println("mouse", mouseX, mouseY);
  }
  
  void dibujarOrbitaCentro(){
    pushMatrix();
    translate(width / 2, height / 2); // Colocar el origen en el centro de la ventana
  
    // Dibujar la órbita menor
    noFill();
    stroke(255);
    ellipse(0, 0, radioOrbita * 2+125, radioOrbita * 2+125);
    popMatrix();
  }
  
  void limitePersonaje() {
    // Obtener la posición actual del main
    PVector mainPosition = new PVector(main.getX(), main.getY());

    // Restringir el movimiento dentro del círculo de radio
    PVector center = new PVector(width/2, height/2);
    PVector offset = PVector.sub(mainPosition, center);
    if (offset.mag() > radioOrbita2 - anchoPersonaje/2) {
      offset.setMag(radioOrbita2 - anchoPersonaje/2);
      mainPosition = PVector.add(center, offset);
      main.setPosition(mainPosition.x, mainPosition.y);
      main.setVelocity(0, 0);
    }
  }
  
  
  void movimientoEstrellas() {
    ArrayList<FBody> cuerpos = mundo.getBodies();
    float factor = 5000;
    
    for (FBody enemigo : cuerpos){ 
      String nombre = enemigo.getName();
      if (nombre != null){
        if (nombre.equals("enemigo")){
          float dx = enemigo.getX() - main.getX();
          float dy = enemigo.getY() - main.getY();
          enemigo.addImpulse(300, 300);
          enemigo.setAngularVelocity(5);          
          enemigo.addForce(dx * factor,dy * factor);
        }
        
        if (nombre.equals("enemigo2")){
          float dx = enemigo.getX() - main.getX();
          float dy = enemigo.getY() - main.getY();
          enemigo.addImpulse(-300, -300);
          enemigo.setAngularVelocity(-5);          
          enemigo.addForce(dx * factor,dy * factor);
        }
      }
    }
  }
  
  void reset(){
    ArrayList<FBody> cuerpos = mundo.getBodies();
    for (FBody enemigo : cuerpos) {
      String nombre = enemigo.getName();
      if (nombre != null) {
        if (nombre.equals("enemigo") || nombre.equals("enemigo2")) {
          enemigo.setPosition(width/2, height/2);
        }
      }
    }
    posX= 0;
    posY=0;
    anchoPersonaje = 120;
    altoPersonaje = 130;
    sizeEstrella = 140;
    radioOrbita = 325; // Radio de la órbita
    i = 0;
    main.setPosition(width/2, height/2);
  }
}
