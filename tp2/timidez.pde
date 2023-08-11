class Timidez {
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
  int radioOrbita2 = 385; // Radio de la órbita
  int i = 0;

  Timidez() {

    pushStyle();
    pushMatrix();
    personaje.resize(120, 130);
    mundo = new FWorld();
    mundo.setEdges(100);
    mundo.setGravity(0, 0);
    posX = posY = 0;


    //myBlob.vertex(0, 0);
    //myBlob.vertex(-anchoPersonaje/2, altoPersonaje/4);
    //myBlob.vertex(-anchoPersonaje/2, altoPersonaje/1.5);
    //myBlob.vertex(600, 400);
    //myBlob.setStatic(true);
    for (int i = 0; i < enemigos.length; i++) {
      float angulo = TWO_PI / enemigos.length * i;
      float x = width / 2 + cos(angulo) * radioOrbita;
      float y = height / 2 + sin(angulo) * radioOrbita;

      enemigos[i] = new FCircle(sizeEstrella);
      enemigos[i].setPosition(x, y);
      enemigos[i].attachImage(estrella);
      enemigos[i].setName("enemigo");
      enemigos[i].setGrabbable(false);

      mundo.add(enemigos[i]);

      // No es necesario crear y añadir FMouseJoint aquí, ya que deseas que los enemigos se muevan automáticamente.
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
    fill(0, 0, 0, 80);
    rect(0, 0, width, height);
    mapeoMain();
    limitePersonaje();

    // Dibujar objetos y actualizar simulación
    mundo.drawDebug();
    mundo.step();
    mundo.draw();

    dibujarOrbitaCentro();
    movimientoEstrellas();
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

      // Calcular la posición en la órbita circular
      float angulo = tiempo * velocidadAngular + TWO_PI / enemigos.length * i;
      float x = width / 2 + cos(angulo) * radioOrbita2;
      float y = height / 2 + sin(angulo) * radioOrbita2;

      enemigo.setPosition(x, y);
      enemigo.setVelocity(0, 0); // Detener cualquier velocidad previa
    }
  }

  void mapeoMain() {
    float minSize = 0.5; // Tamaño mínimo cuando está cerca de los enemigos
    float maxSize = 1.0; // Tamaño normal cuando está lejos de los enemigos
    float distanciaMinima = radioOrbita2 - anchoPersonaje / 2;

    // Calcular la distancia entre el main y el centro
    PVector mainPosition = new PVector(main.getX(), main.getY());
    PVector center = new PVector(width / 2, height / 2);
    float distanciaMainCentro = mainPosition.dist(center);

    // Mapear el tamaño en función de la distancia al centro
    float sizeFactor = map(distanciaMainCentro, 0, distanciaMinima, maxSize, minSize);

    // Ajustar el tamaño del cuerpo principal
    //main.setWidth(anchoPersonaje * sizeFactor);
    //main.setHeight(altoPersonaje * sizeFactor);

    // Ajustar el tamaño de la imagen adjunta
    pushStyle();
    personaje.resize(int(anchoPersonaje * sizeFactor), int(altoPersonaje * sizeFactor));
    main.attachImage(personaje);
    popStyle();
  }
  
  void reset(){
    main.setPosition(width/2,height/2);
    personaje.resize(120,130);
  }

}
