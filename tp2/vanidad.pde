class Vanidad {
  FWorld mundo;

  PImage[] personajes = new PImage[15];
  FCircle main;
  FCircle ancla;
  FCircle[] enemigos = new FCircle[5];
  FDistanceJoint cadenaPersonaje;
  FMouseJoint cadena;
  //ArrayList<FDistanceJoint> cadenas;
  //FRevoluteJoint rAncla;
  int factor = 1;
  float posX, posY;
  //120 y 130
  int anchoPersonaje = 120;
  int altoPersonaje = 130;
  int sizeEstrella = 140;
  int radioOrbita = 325; // Radio de la órbita
  int radioOrbita2 = 385; // Radio de la órbita
  int i = 0;
  boolean mainTouching=false;
  boolean[] collision = new boolean[enemigos.length];

  Vanidad() {

    pushStyle();
    pushMatrix();
    personaje.resize(120, 130);
    mundo = new FWorld();
    mundo.setGravity(0, 0);
    posX = posY = 0;
    
     for (int i=0; i < 12; i++){
      int nuevoAncho = 120 + i * 50; // Aumenta el ancho
      int nuevoAlto = 130 + i * 50; // Aumenta el alto
      personajes[i] = loadImage("/data/personaje.png");
      personajes[i].resize(nuevoAncho, nuevoAlto);
      
    }


    for (int i = 0; i < enemigos.length; i++) {
      float angulo = TWO_PI / enemigos.length * i;
      float x = width / 2 + cos(angulo) * radioOrbita;
      float y = height / 2 + sin(angulo) * radioOrbita;

      enemigos[i] = new FCircle(sizeEstrella);
      enemigos[i].setPosition(x, y);
      enemigos[i].attachImage(estrella);
      enemigos[i].setName("enemigo");
      enemigos[i].setGrabbable(true);
      mundo.add(enemigos[i]);
    }
    // Personaje principal
    main = new FCircle(anchoPersonaje);
    main.setPosition(width/2, height/2);
    main.setStatic(true);
    main.setGrabbable(false);
    main.attachImage(personajes[0]);
    


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
    //mundo.add(cadenaPersonaje);

    popMatrix();
    popStyle();
  }

  void actualizar() {
    fill(0, 0, 0, 80);
    rect(0, 0, width, height);
    
 
    //aumentarTamaño();
    //limitePersonaje();

    // Dibujar objetos y actualizar simulación
    //mundo.drawDebug();
    mundo.step();
    mundo.draw();
    borrarMundo();
    dibujarOrbitaCentro();
    movimientoEstrellas();

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



  void movimientoEstrellas() {
    float tiempo = millis() * 0.001; // Tiempo en segundos
    float velocidadAngular = 0.5; // Velocidad angular en radianes por segundo

    for (int i = 0; i < enemigos.length; i++) {
      FCircle enemigo = enemigos[i];
      float factor = 8000;
      // Calcular la posición en la órbita circular
      float angulo = tiempo * velocidadAngular + TWO_PI / enemigos.length * i;
      float x = width / 2 + cos(angulo) * radioOrbita2;
      float y = height / 2 + sin(angulo) * radioOrbita2;

      if (detectarColision(enemigo)) {
        collision[i] = true;
      }

      if (collision[i]) {
        //float x = enemigo.getX();
        
        enemigo.addImpulse(1000, 1000);
        enemigo.setAngularVelocity(5);
        enemigo.addForce(factor, factor);
        enemigo.setVelocity(1000, 1000);
      } else {
        enemigo.setPosition(x, y);
        enemigo.setVelocity(0, 0); // Detener cualquier velocidad previa
      }
    }
  }

  void touch() {
    PVector mousePos = new PVector(mouseX, mouseY);
    PVector mainPos = new PVector(main.getX(), main.getY());

    if (PVector.dist(mousePos, mainPos) < main.getSize() / 2) {
      mainTouching = true;
      aumentarTamaño();
    }
  }
  void release() {
    mainTouching = false;
  }

  boolean detectarColision(FBody enemigo) {
    if (main.isTouchingBody(enemigo)) {
      println("anda", enemigo);
      return true;
    } else {
      return false;
    }
  }

  void aumentarTamaño() {
    if (main.getSize() < 650) { // Evita que el objeto se vuelva demasiado grande
      println(main.getSize());
      float nuevoAncho = main.getSize() + 50; // Aumenta el ancho
      main.setSize(nuevoAncho); // Actualiza el tamaño del objeto
      //main.setHeight(nuevoAlto);
      pushStyle();      
      main.attachImage(personajes[factor]);
      popStyle();
          
      ajustarAncla(); // Ajusta la posición del objeto ancla
      factor++;
    } else if (main.getSize() == 700) {
    }
  }

  void ajustarAncla() {
    PVector mainPos = new PVector(main.getX(), main.getY());
    PVector center = new PVector(width/2, height/2);

    // Calcula la posición del ancla para mantener la distancia original entre ellos
    PVector offset = PVector.sub(mainPos, center);
    offset.setMag(radioOrbita2 - main.getSize() / 2);
    PVector anclaPos = PVector.add(center, offset);

    ancla.setPosition(anclaPos.x, anclaPos.y);

    // Actualiza la distancia de la cadena
    cadenaPersonaje.setLength(main.getSize() / 2);
  }

  void borrarMundo() {
    //esto es un intento para optimizar el codigo y que funcione mejor, pero no está funcionando bien

    for (int i = 0; i < enemigos.length; i++) {
      FCircle enemigo = enemigos[i];

      if (enemigo.getX() > width+100 || enemigo.getX() < 0 || enemigo.getY() > height+100 || enemigo.getY() < 0) {
        
        enemigo.setStatic(true);
        //enemigo.removeFromWorld();

      }
    }
  }


  void reset() {
    mundo.clear();
    anchoPersonaje = 120;
    altoPersonaje = 130;
    sizeEstrella = 140;
    mainTouching=false;
    main.setPosition(width/2,height/2);
    personaje.resize(120, 130);
    factor = 1;
    main.attachImage(personajes[0]);
    main.setSize(anchoPersonaje);
    ancla.setPosition(width/2, height/2);
    //main.setHeight(altoPersonaje);

    for (int i = 0; i < enemigos.length; i++) {
      float angulo = TWO_PI / enemigos.length * i;
      float x = width / 2 + cos(angulo) * radioOrbita;
      float y = height / 2 + sin(angulo) * radioOrbita;
      
      enemigos[i].setPosition(x, y);
      enemigos[i].attachImage(estrella);
      enemigos[i].setName("enemigo");
      enemigos[i].setGrabbable(true);
      collision[i] = false;
      enemigos[i].setStatic(false);
      mundo.add(enemigos[i]);
    }
  }
}
