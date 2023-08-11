class Empatia {
  FWorld mundo;

  FBox main;
  FCircle ancla;
  FCircle[] enemigos = new FCircle[5];
  FDistanceJoint cadenaPersonaje;
  FMouseJoint cadena;
  float posX, posY;
  float anguloRotacion = 0;
  //120 y 130
  int anchoPersonaje = 120-20;
  int altoPersonaje = 130-20;
  int sizeEstrella = 140;
  int radioOrbita = 325; // Radio de la órbita
  int radioOrbita2 = 385; // Radio de la órbita
  int limiteExtendidoMain = 450;
  int i = 0;

  Empatia() {
    pushStyle();
    pushMatrix();
    personaje.resize(anchoPersonaje, altoPersonaje);
    mundo = new FWorld();
    mundo.setEdges(100);
    mundo.setGravity(0, 0);
    posX = posY = 0;

    for (int i = 0; i < enemigos.length; i++) {
      float angulo = TWO_PI / enemigos.length * i;
      float x = width / 2 + cos(angulo) * radioOrbita;
      float y = height / 2 + sin(angulo) * radioOrbita;

      enemigos[i] = new FCircle(sizeEstrella);
      enemigos[i].setPosition(x, y);
      enemigos[i].setSensor(true); //desactivo colisiones
      enemigos[i].attachImage(estrella);
      enemigos[i].setName("enemigo");
      enemigos[i].setGrabbable(false);
      mundo.add(enemigos[i]);
    }

    // Personaje principal
    main = new FBox(anchoPersonaje, altoPersonaje);
    main.setPosition(width/2, height/2);
    main.setRotation(0);
    main.setStatic(true);

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
    limitePersonaje();

    // Dibujar objetos y actualizar simulación
    //mundo.drawDebug();
    mundo.step();
    mundo.draw();

    dibujarOrbitaCentro();
    movimientoEstrellas();
    verificarContacto();

    pushStyle();
    personaje.resize(int(anchoPersonaje), int(altoPersonaje));
    main.attachImage(personaje);
    popStyle();
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

  void verificarContacto() {
    for (int i = 0; i < enemigos.length; i++) {
      FCircle enemigo = enemigos[i];


      // Verificar si el personaje principal está en contacto con el enemigo
      if (main.isTouchingBody(enemigo)) {
        /*
        pushStyle();
         fill(255, 0, 0);
         textSize(25);
         text("ESTÁ EMPATIZANDO", width/2, height/2);
         println(anguloRotacion);
         popStyle();
         */
        anguloRotacion += radians(1);
        main.setRotation(anguloRotacion);
        main.setPosition(enemigo.getX(), enemigo.getY());
      }else{
        //main.setRotation(0);
      }
    }
  }

  void movimientoEstrellas() {
    float tiempo = millis() * 0.001; // Tiempo en segundos
    float velocidadAngular = 0.5; // Velocidad angular en radianes por segundo

    for (int i = 0; i < enemigos.length; i++) {
      FCircle enemigo = enemigos[i];

      // Calcular la posición en la órbita circular
      float angulo = tiempo * velocidadAngular + TWO_PI / enemigos.length * i;
      float x = width / 2 + cos(angulo) * radioOrbita2;
      float y = height / 2 + sin(angulo) * radioOrbita2;

      enemigo.setPosition(x, y);
      enemigo.setVelocity(0, 0); // Detener cualquier velocidad previa
    }
  }
  
  void reset(){
    main.setPosition(width/2, height/2);
    main.setRotation(0);
  }
}
