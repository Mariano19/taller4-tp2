class Acoso {
  FWorld mundo;

  
  FBox main;
  FCircle ancla;
  FCircle[] enemigos = new FCircle[5];
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

  Acoso() {
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
    fill(0,0,0,80);
    rect(0,0,width,height);
    //background(255);
    //println("entro mediacion");
    
    //mundo.drawDebug();
    mundo.step();
    mundo.draw();
    
    dibujarOrbitaCentro();    
    movimientoEstrellas();
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
    float posX = main.getX();
    float posY = main.getY();
    float dist = dist(main.getX(), main.getY(), ancla.getX(), ancla.getY());
    if(dist> 250) {
      main.setPosition(mouseX, mouseY);
    } else{
      //main.setPosition();
    }
    println("dist", dist);

  //posX > width/2-radioOrbita && posX < width/2+radioOrbita
  }
  
  
  void movimientoEstrellas() {
    ArrayList<FBody> cuerpos = mundo.getBodies();
    float factor = 5000;
    
    for (FBody enemigo : cuerpos){ 
      String nombre = enemigo.getName();
      if (nombre != null){
        if (nombre.equals("enemigo")){
          float dx = main.getX() - enemigo.getX();
          float dy = main.getY() - enemigo.getY();
          enemigo.addImpulse(300, 300);
          enemigo.setAngularVelocity(5);          
          enemigo.addForce(dx * factor,dy * factor);
        }
      }
    }
  }
}
