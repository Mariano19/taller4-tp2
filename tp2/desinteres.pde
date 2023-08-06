class Desinteres {

  int radioOrbita = 200; // Radio de la órbita
  int numCirculos = 5;   // Número de círculos en el borde de la elipse
  float cercaniaLimite = 300; // Distancia límite para mover los círculos
  float offsetFactor = 6; // Factor de ajuste del offset (puedes cambiar este valor)

  // Arreglo de objetos para almacenar los círculos en la órbita izquierda
  Circulo[] circulosIzquierda = new Circulo[numCirculos];

  // Variables globales para las coordenadas x e y de la posición de la elipse de la línea 20
  float x;
  float y;

  //Personaje
  int anchoPersonaje = 120;
  int altoPersonaje = 130;
  PGraphics pg;

  Desinteres() {
    imageMode(CENTER);
    // Inicializar los objetos Circulo y sus coordenadas en la órbita izquierda
    for (int i = 0; i < numCirculos; i++) {
      float angulo = TWO_PI * i / numCirculos;
      float x = radioOrbita * cos(angulo);
      float y = radioOrbita * sin(angulo);
      circulosIzquierda[i] = new Circulo(x, y);
    }
    pg = createGraphics(anchoPersonaje, altoPersonaje); //PGraphics for the main element to allow self rotation
  }

  void actualizar() {
    background(0);
    dibujarOrbitaCentro();
    dibujarOrbitaIzquierda();
    //dibujarOrbitaDerecha();

    // Obtener la posición del mouse con respecto al centro de la pantalla
    float mouseXOffset = mouseX - width / 2;
    float mouseYOffset = mouseY - height / 2;

    // Calcular el ángulo entre el centro de la pantalla y la posición del mouse
    float mouseAngle = atan2(mouseYOffset, mouseXOffset);

    // Calcular posición de la elipse de la línea 20 en función del ángulo y el radio de la órbita
    x = 350 * cos(mouseAngle);
    y = 350 * sin(mouseAngle);

    // Verificar si el círculo controlado por el mouse está cerca de la posición objetivo
    if (dist(x, y, -80, -80) < cercaniaLimite) {
      // Calcular las coordenadas polares de la esquina superior izquierda de la órbita
      float anguloEsquina = atan2(-80, -80);
      float radioEsquina = sqrt(sq(-80) + sq(-80));

      // Calcular el ángulo de separación entre las esferas en la esquina
      float anguloSeparacion = PI / (numCirculos - 1);

      // Calcular las posiciones de las esferas en el borde del radio de la órbita
      for (int i = 0; i < numCirculos; i++) {
        float anguloFinal = anguloEsquina + i * anguloSeparacion;
        float offsetX = offsetFactor * 15 * cos(anguloFinal); // Offset con factor de ajuste
        float offsetY = offsetFactor * 15 * sin(anguloFinal);
        float targetX = -80 + offsetX;
        float targetY = -80 + offsetY;
        circulosIzquierda[i].iniciarAnimacion(targetX, targetY);
      }
    }

    // Actualizar la animación de cada círculo en la órbita izquierda
    for (int i = 0; i < numCirculos; i++) {
      circulosIzquierda[i].actualizar();
    }
  }


  void dibujarOrbitaIzquierda() {
    pushMatrix();
    translate(width / 5, height / 4); // Colocar el origen en el centro de la ventana

    // Dibujar la órbita izquierda
    noFill();
    stroke(255);
    ellipse(0, 0, radioOrbita * 2, radioOrbita * 2);

    // Dibujar los círculos en el borde de la elipse
    for (int i = 0; i < numCirculos; i++) {
      circulosIzquierda[i].dibujar();
    }

    popMatrix();
  }

  void dibujarOrbitaCentro() {
    pushMatrix();
    translate(width / 2, height / 2); // Colocar el origen en el centro de la ventana

    // Dibujar la órbita menor
    noFill();
    stroke(255);
    ellipse(0, 0, 700, 700);

    // Dibujar la elipse de la línea 20 en su posición calculada
    stroke(255);
    fill(0); // Color del círculo
    ellipseMode(CENTER); // El círculo se dibuja desde su centro
    //ellipse(x, y, 50, 50); // Dibujar el círculo
    image(personaje, x, y, anchoPersonaje, altoPersonaje);
    println(x, y);
    popMatrix();
  }

  // Clase para representar cada círculo en la órbita izquierda
  class Circulo {
    float x;
    float y;
    float targetX;
    float targetY;
    boolean animating;
    float animStep;

    Circulo(float x, float y) {
      this.x = x;
      this.y = y;
      this.targetX = x;
      this.targetY = y;
      this.animating = false;
      this.animStep = 0.0;
    }

    void iniciarAnimacion(float targetX, float targetY) {
      this.targetX = targetX;
      this.targetY = targetY;
      this.animating = true;
    }

    void actualizar() {
      if (this.animating) {
        if (this.animStep < 1.0) {
          this.animStep += 0.01; // Incrementar el paso de la animación
          this.x = lerp(this.x, this.targetX, this.animStep);
          this.y = lerp(this.y, this.targetY, this.animStep);

          // Mantener las esferas en el borde del radio de la órbita izquierda
          float distanciaCentro = dist(0, 0, this.x, this.y);
          this.x = this.x * radioOrbita / distanciaCentro;
          this.y = this.y * radioOrbita / distanciaCentro;
        } else {
          this.animating = false; // Finalizar la animación
          this.animStep = 0.0; // Reiniciar el paso de la animación
        }
      }
    }

    void dibujar() {
      image(estrella, this.x, this.y, 100, 100); // Mostrar la imagen en la posición del círculo
    }
  }
}
