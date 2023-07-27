class Timidez {
  float orbitaRotation1 = 0;
  float orbitaRotation2 = 0; 
  float circleX = 0;
  float circleY = 0;
  float delay = 0.2; // Ajusta este valor para cambiar la cantidad de retraso (0 a 1, donde 1 es sin retraso)

  Timidez() {
    imageMode(CENTER);
  }

  void actualizar() {
    // Rotar los rectángulos sobre su propio eje
    orbitaRotation1 += 0.02;
    orbitaRotation2 -= 0.03;


    pushMatrix();
    translate(50, 50); 
    rotate(orbitaRotation1);
    image(orbitaVanidad, 0, 0); 
    popMatrix();

 
    pushMatrix();
    translate(width - 50, height - 50); 
    rotate(orbitaRotation2);
    image(orbitaVanidad, 0, 0); 
    popMatrix();

   
    float targetX = mouseX;
    float targetY = mouseY;
    circleX = lerp(circleX, targetX, delay);
    circleY = lerp(circleY, targetY, delay);

    // Calcular la distancia entre el círculo y las orbitas
    float distanceToBlueSquare = dist(circleX, circleY, 50, 50);
    float distanceToGreenSquare = dist(circleX, circleY, width - 50, height - 50);

    // Calcular el tamaño del círculo basado en la distancia a las orbitas
    float circleSize = map(max(distanceToBlueSquare, distanceToGreenSquare), 0, 300, 50, 25);

    // Dibujar el círculo en la posición con el tamaño calculado
    fill(0, 0, 0); // Relleno rojo
    ellipse(circleX, circleY, circleSize, circleSize);
  }
}
