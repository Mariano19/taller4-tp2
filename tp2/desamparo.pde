class Desamparo {
  FWorld mundo;
  FCircle main;
  FCircle ancla;
  FCircle[] enemigos = new FCircle[5];
  FDistanceJoint cadenaPersonaje;
  FMouseJoint cadena;
  float posX, posY;
  //120 y 130
  int anchoPersonaje = 120;
  int altoPersonaje = 130;
  int sizeEstrella = 140;
  int radioOrbita = 325; // Radio de la órbita
  //int radioOrbita2 = 800; // Radio de la órbita
  int i = 0;
  boolean mainTouching=false;
  boolean[] collision = new boolean[enemigos.length];

  Desamparo() {

    pushStyle();
    pushMatrix();
    personaje.resize(120, 130);
    mundo = new FWorld();
    mundo.setEdges();
    mundo.setGravity(0, 0);
    posX = posY = 0;

    for (int i = 0; i < enemigos.length; i++) {
      float angulo = TWO_PI / enemigos.length * i;
      float x = width / 2 + cos(angulo) * radioOrbita *1.5 ;
      float y = height / 2 + sin(angulo) * radioOrbita*1.5;

      enemigos[i] = new FCircle(sizeEstrella);
      enemigos[i].setPosition(x, y);
      enemigos[i].attachImage(estrella);
      enemigos[i].setName("enemigo");
      enemigos[i].setGrabbable(true);
      enemigos[i].setStatic(false);
      mundo.add(enemigos[i]);
    }

    // Personaje principal
    main = new FCircle(anchoPersonaje);
    main.setPosition(width/2, height/2);
    main.setStatic(true);
    main.setGrabbable(false);
    main.attachImage(personaje);

    // Anclaje
    ancla = new FCircle(radioOrbita*2);
    ancla.setDrawable(false);
    ancla.setPosition(width/2, height/2);
    ancla.setGrabbable(false);
    ancla.setStatic(true);

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
    fill(0, 0, 0, 80);
    rect(0, 0, width, height);


    //aumentarTamaño();
    //limitePersonaje();
    dibujarOrbitaCentro();
    atraccionCentro();
    
    
    // Dibujar objetos y actualizar simulación
    //mundo.drawDebug();
    mundo.step();
    mundo.draw();
  }
  

  void atraccionCentro() {
    PVector mousePos = new PVector(mouseX, mouseY);
    PVector mainPos = new PVector(main.getX(), main.getY());
    
    if (mousePressed) {
      if (PVector.dist(mousePos, mainPos) < main.getSize() / 2) {
      ArrayList<FBody> cuerpos = mundo.getBodies();
      float factor = 1000;

      for (FBody enemigo : cuerpos) {
        String nombre = enemigo.getName();
        if (nombre != null) {
          if (nombre.equals("enemigo")) {
            float dx = main.getX() - enemigo.getX();
            float dy = main.getY() - enemigo.getY();
            enemigo.addImpulse(300, 300);
            enemigo.setAngularVelocity(5);
            enemigo.addForce(dx * factor, dy * factor);
          }}
        }
      }
    }
  }

  void dibujarOrbitaCentro() {
    pushMatrix();
    translate(width / 2, height / 2); // Colocar el origen en el centro de la ventana

    // Dibujar la órbita menor
    noFill();
    stroke(255);
    ellipse(0, 0, radioOrbita * 2+125, radioOrbita * 2+125);
    popMatrix();
  }
  
  void reset(){
    for (int i = 0; i < enemigos.length; i++) {
      float angulo = TWO_PI / enemigos.length * i;
      float x = width / 2 + cos(angulo) * radioOrbita *1.5 ;
      float y = height / 2 + sin(angulo) * radioOrbita*1.5;


      enemigos[i].setPosition(x, y);

    }
  }
}
