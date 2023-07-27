class Timidez {
  float blueRotation = 0;
  float greenRotation = 0;
  float circleX = 0;
  float circleY = 0;
  float delay = 0.2; // Ajusta este valor para cambiar la cantidad de retraso (0 a 1, donde 1 es sin retraso)

  Timidez() {
    imageMode(CENTER);
  }

  void actualizar() {
    // Rotar los rectángulos sobre su propio eje
    blueRotation += 0.02;
    greenRotation -= 0.03;

    // Dibujar cuadrado azul en la esquina superior izquierda y rotarlo
    pushMatrix();
    translate(50, 50); // Posición del cuadrado azul
    rotate(blueRotation);
    image(orbitaVanidad, 0, 0); // Tamaño del cuadrado azul
    popMatrix();

    // Dibujar cuadrado verde en la esquina inferior derecha y rotarlo
    pushMatrix();
    translate(width - 50, height - 50); // Posición del cuadrado verde
    rotate(greenRotation);
    image(orbitaVanidad, 0, 0); // Tamaño del cuadrado verde
    popMatrix();

    // Obtener la posición del mouse con el pequeño retraso
    float targetX = mouseX;
    float targetY = mouseY;
    circleX = lerp(circleX, targetX, delay);
    circleY = lerp(circleY, targetY, delay);

    // Calcular la distancia entre el círculo y los rectángulos
    float distanceToBlueSquare = dist(circleX, circleY, 50, 50);
    float distanceToGreenSquare = dist(circleX, circleY, width - 50, height - 50);

    // Calcular el tamaño del círculo basado en la distancia a los rectángulos
    float circleSize = map(max(distanceToBlueSquare, distanceToGreenSquare), 0, 300, 50, 25);

    // Dibujar el círculo en la posición con el tamaño calculado
    fill(0, 0, 0); // Relleno rojo
    ellipse(circleX, circleY, circleSize, circleSize);
  }
}
