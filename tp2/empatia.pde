class Empatia {
  float orbitaRotation1 = 0;
  float orbitaRotation2 = 0; 
  float circleX = 0;
  float circleY = 0;
  float delay = 0.1; // Ajusta este valor para cambiar la cantidad de retraso (0 a 1, donde 1 es sin retraso)
    int anchoPersonaje = 120;
  int altoPersonaje = 130;
  PGraphics pg;
  
  float vel = 0;
  float radiusX = 350; // Orbit width
  float radiusY = 350; // Orbit height
  float posY = 0;
  float posX = 0;
  
  Empatia(){
    imageMode(CENTER);
     pg = createGraphics(anchoPersonaje, altoPersonaje); //PGraphics for the main element to allow self rotation
  }

  void actualizar() {
    background(0);
    // Rotar los rectángulos sobre su propio eje
    orbitaRotation1 += 0.02;
    orbitaRotation2 -= 0.03;

    pushMatrix();
    translate(400, 100); 
    rotate(orbitaRotation1);
    image(orbitaVanidad, 0, 0, 1000,1000); 
    popMatrix();

    pushMatrix();
    translate(width - 50, height - 50); 
    rotate(orbitaRotation2);
    image(orbitaVanidad, 0, 0,900,900); 
    popMatrix();

    float targetX = mouseX;
    float targetY = mouseY;
    circleX = lerp(circleX, targetX, delay);
    circleY = lerp(circleY, targetY, delay);

    // Calcular la distancia entre el círculo y las orbitas
    float distanceToBlueSquare = dist(circleX, circleY, 50, 50);
    float distanceToGreenSquare = dist(circleX, circleY, width - 50, height - 50);

    // Calcular el tamaño del círculo basado en la distancia a las orbitas
    float circleSize = map(min(distanceToGreenSquare, distanceToBlueSquare), 300, 0, 50,10);
    //float circleSize = map(max(distanceToBlueSquare, distanceToGreenSquare), 300, 0, -10,00);
    // Dibujar el círculo en la posición con el tamaño calculado
    fill(0, 0, 0); 
    
    posX = radiusX * cos( vel );
    posY = radiusY * sin( vel );
    
    // Moving object
    
    
    //float distancia = dist(circleX, circleY, posX+400, posY+100);
    float distancia = dist(circleX, circleY, posX+400, posY+100);
    if(mouseHover()){
      pushMatrix();        
      translate(400, 100);
      fill( 255 );
      //rotate(radians(frameCount*2));
      ellipse( posX, posY, 100, 100 );
      
      image(personaje, posX, posY, anchoPersonaje, altoPersonaje);
      popMatrix();
      println("anda");
    } else {
      image(personaje, circleX, circleY, anchoPersonaje, altoPersonaje);
    }
    //println(circleX, circleY, posX+400, posY+100);
    
    
    vel += 0.020;
  }
  
  boolean mouseHover() {
      //println(x,y, mouseX, mouseY );
      return circleX < 700 && circleY < 450;
    }
}
