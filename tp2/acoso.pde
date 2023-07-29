class Acoso {
  int orbitRadiusMenor = 100; // Radio de la órbita menor
  int orbitRadiusMayor = 200; // Radio de la órbita mayor
  int numCircles = 5; // Número de círculos en la órbita mayor
  float angleOffset = TWO_PI / numCircles; // Espaciado entre los círculos en la órbita mayor
  float orbitSpeed = 0.01; // Velocidad de la órbita mayor
  float minImageScale = 0.8; // Escala mínima de la imagen de los círculos
  float maxImageScale = 0.8; // Escala máxima de la imagen de los círculos
  int anchoPersonaje = 55;
  int altoPersonaje = 60;
  PGraphics pg;

  Acoso() {
    imageMode(CENTER);
    pg = createGraphics(anchoPersonaje, altoPersonaje); //PGraphics for the main element to allow self rotation
  }

  void actualizar() {
    background(0);
    translate(width / 2, height / 2); // Colocar el origen en el centro de la ventana

    // Dibujar la órbita mayor
    noFill();
    stroke(255);
    ellipse(0, 0, orbitRadiusMayor * 2, orbitRadiusMayor * 2);

    // Dibujar la órbita menor
    noFill();
    stroke(255);
    ellipse(0, 0, orbitRadiusMenor * 2, orbitRadiusMenor * 2);

    // Calcular y dibujar el cuadrado que sigue al mouse dentro de la órbita menor
    float mouseXOffset = mouseX - width / 2; // Calcular el desplazamiento del mouse en x
    float mouseYOffset = mouseY - height / 2; // Calcular el desplazamiento del mouse en y

    // Verificar si el cuadrado está dentro de la circunferencia de la órbita menor
    float distanceFromCenter = dist(0, 0, mouseXOffset, mouseYOffset);

    if (distanceFromCenter > orbitRadiusMenor) {

      mouseXOffset = mouseXOffset * orbitRadiusMenor / distanceFromCenter;
      mouseYOffset = mouseYOffset * orbitRadiusMenor / distanceFromCenter;
    } else {

      float angle = atan2(mouseYOffset, mouseXOffset);
      mouseXOffset = orbitRadiusMenor * cos(angle);
      mouseYOffset = orbitRadiusMenor * sin(angle);
    }

    stroke(255);
    fill(0); // Color del cuadrado (negro)
    ellipseMode(CENTER); // El cuadrado se dibuja desde su centro
    ellipse(mouseXOffset, mouseYOffset, 50, 50); // Dibujar el cuadrado
    image(personaje, mouseXOffset, mouseYOffset, anchoPersonaje, altoPersonaje);


    // Dibujar los cinco círculos en la órbita mayor
    for (int i = 0; i < numCircles; i++) {
      float angle = i * angleOffset + frameCount * orbitSpeed;
      float x = orbitRadiusMayor * cos(angle);
      float y = orbitRadiusMayor * sin(angle);

      // Calcular la escala
      float distanceFromCenterMayor = dist(0, 0, x, y);
      float scale = map(distanceFromCenterMayor, 0, orbitRadiusMayor, maxImageScale, minImageScale);
      scale = constrain(scale, minImageScale, maxImageScale);

      // Dibujar las estrellas
      pushMatrix();
      translate(x, y);
      image(estrella, 0, 0, estrella.width * scale, estrella.height * scale);
      popMatrix();
    }
  }
}
