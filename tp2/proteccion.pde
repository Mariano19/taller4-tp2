class Proteccion {
  FWorld mundo;

  FBox main;
  FCircle ancla;
  FCircle[] enemigos = new FCircle[3];
  FCircle[] noEnemigos = new FCircle[3];
  FDistanceJoint cadenaPersonaje;
  FMouseJoint cadena;

  float posX, posY;
  float offset = 2;
  int anchoPersonaje = 120;
  int altoPersonaje = 130;
  int sizeEstrella = 140;
  int radioOrbita = 325; // Radio de la órbita
  int radioOrbita2 = 385; // Radio de la órbita
  int limiteExtendidoMain = 450;
  int i = 0;
  float velocidadX = random(-1000,1000);
  float velocidadY = random(-1000,1000);

  boolean[] collision = new boolean[enemigos.length];


  Proteccion() {
    pushStyle();
    pushMatrix();
    personaje.resize(anchoPersonaje, altoPersonaje);
    mundo = new FWorld();
    //mundo.setEdges(100);
    mundo.setGravity(0, 0);
    posX = posY = 0;

    for (int i = 0; i < enemigos.length; i++) {
      float angulo = TWO_PI / enemigos.length * i;
      float x = width / 2 + cos(angulo) * radioOrbita;
      float y = height / 2 + sin(angulo) * radioOrbita;

      enemigos[i] = new FCircle(sizeEstrella);
      enemigos[i].setPosition(x, y);
      enemigos[i].setSensor(false); //desactivo colisiones
      enemigos[i].attachImage(estrellamala);
      enemigos[i].setName("enemigo");
      enemigos[i].setGrabbable(false);
      mundo.add(enemigos[i]);
    }

    for (int i = 0; i < noEnemigos.length; i++) {
      
      float angulo = TWO_PI  / noEnemigos.length * i ;
      float x = width / 2 + cos(angulo) * radioOrbita;
      float y = height / 2 + sin(angulo) * radioOrbita ;

      noEnemigos[i] = new FCircle(sizeEstrella);
      noEnemigos[i].setPosition(x, y);
      noEnemigos[i].setSensor(true); //desactivo colisiones
      noEnemigos[i].attachImage(estrella);
      noEnemigos[i].setName("noEnemigo");
      noEnemigos[i].setGrabbable(false);
      mundo.add(noEnemigos[i]);
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

   // mundo.add(ancla);
    mundo.add(main);


    popMatrix();
    popStyle();
  }

  void actualizar() {
    fill(0, 0, 0, 80);
    rect(0, 0, width, height);
    limitePersonaje();

    // Dibujar objetos y actualizar simulación


    dibujarOrbitaCentro();
    movimientoEstrellas();
    movimientoNoEnemigo();
    //verificarContacto();

    mundo.drawDebug();
    mundo.step();
    mundo.draw();
  }

  void limitePersonaje() {
    // Obtener la posición actual del main
    PVector mainPosition = new PVector(main.getX(), main.getY());

    // Restringir el movimiento dentro del círculo de radio
    PVector center = new PVector(width/2, height/2);
    PVector offset = PVector.sub(mainPosition, center);
    if (offset.mag() > limiteExtendidoMain - anchoPersonaje/2) {
      offset.setMag(limiteExtendidoMain - anchoPersonaje/2);
      mainPosition = PVector.add(center, offset);
      main.setPosition(mainPosition.x, mainPosition.y);
      main.setVelocity(0, 0);
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


  boolean detectarColision(FBody enemigo) {
    if (main.isTouchingBody(enemigo)) {
      println("anda", enemigo);
      return true;
      
    } else {
      return false;
    }
  }

  void movimientoEstrellas() {
    float tiempo = millis() * 0.0015; // Tiempo en segundos
    float velocidadAngular = 0.5; // Velocidad angular en radianes por segundo

      
    for (int i = 0; i < enemigos.length; i++) {
      FCircle enemigo = enemigos[i];
      float factor = 8000;
      // Calcular la posición en la órbita circular
      float angulo = tiempo * velocidadAngular  + TWO_PI / enemigos.length * i;
      float x = width / 2 + cos(angulo)  * radioOrbita2;
      float y = height / 2 + sin(angulo) * radioOrbita2;
      

      if (detectarColision(enemigo)) {
        collision[i] = true;

      }

      if (collision[i]) {
        //float x = enemigo.getX();
        //enemigo.addImpulse(1000, 1000);
        enemigo.setAngularVelocity(5);
        //enemigo.addForce(factor, factor);
        enemigo.setVelocity(width/2,height+400);
        
    
        
      } else {
        enemigo.setPosition(x, y);
        enemigo.setVelocity(0, 0); // Detener cualquier velocidad previa
      }
    }
  }

  void movimientoNoEnemigo() {
    float tiempo = millis() * 0.001; // Tiempo en segundos
    float velocidadAngular = 0.5; // Velocidad angular en radianes por segundo
    
    for (int i = 0; i < noEnemigos.length; i++) {
      FCircle noenemigo = noEnemigos[i];

      // Calcular la posición en la órbita circular
      float angulo = tiempo * velocidadAngular + TWO_PI / noEnemigos.length * i;
      float x = width / 2 + cos(angulo) * radioOrbita2;
      float y = height / 2 + sin(angulo) * radioOrbita2;

      noenemigo.setPosition(x, y);
      noenemigo.setVelocity(0, 0); // Detener cualquier velocidad previa
    }
  }
  
    void reset() {
    anchoPersonaje = 120;
    altoPersonaje = 130;
    sizeEstrella = 140;
    //mainTouching=false;
    main.setPosition(width/2,height/2);
    personaje.resize(120, 130);
    //main.setSize(anchoPersonaje);
    //main.setHeight(altoPersonaje);

    for (int i = 0; i < enemigos.length; i++) {
      float angulo = TWO_PI / enemigos.length * i;
      float x = width / 2 + cos(angulo) * radioOrbita;
      float y = height / 2 + sin(angulo) * radioOrbita;
      
      enemigos[i].setPosition(x, y);
      enemigos[i].attachImage(estrellamala);
      //enemigos[i].setName("enemigo");
      enemigos[i].setGrabbable(true);
      mundo.add(enemigos[i]);
      collision[i] = false;
      enemigos[i].setStatic(false);
    }
  }
  
}
