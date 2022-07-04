/**
Parte sujeta a cambios
*/

private Jugador jugador;
private Interfaz interfaz;
private int estadoJuego;
private int nivelActual;
private Nivel nivelEnCurso;

void setup() {
  size(600, 630);
  estadoJuego = MaquinaEstados.ESTADO_INICIO;
  nivelActual = 1;
  //niveles = new Nivel[2];
}

void draw() {
  switch (estadoJuego) {
    case MaquinaEstados.ESTADO_INICIO:
      background(0);
      text("INICIOOOO", width/2, height/2);
      break;
    case MaquinaEstados.ESTADO_JUGANDO:
      nivelEnCurso.display();
      jugador.display();
      jugador.move();
      interfaz.display();
      break;
    case MaquinaEstados.ESTADO_GANADO:
      limpiarPantalla();
      text("GANASTEEEEEEE", width/2, height/2);
      text(String.format("Puntaje: %d", jugador.getPuntaje()), width/2, height/2+50);
      // TODO: Puntaje adicional por vida
      // TODO: puntaje adicionar por tiros usados
      break;
    case MaquinaEstados.ESTADO_PERDIDO:
      limpiarPantalla();
      text("PERDISTE BOBO", width/2, height/2);
      break;
  }
}

void inicio() {
  // Dependiendo el nivel en curso, se dibuja e instancia en pantalla
  // su nivel correspondiente y tambien sus enemigos y obstaculos.
  switch (nivelActual) {
    case 1:
      // NIVEL 1
      
      // Se crea al jugador
      jugador = new Jugador(575, 300, 5, 2, null);
      
      // Crea el nivel
      nivelEnCurso = new Nivel(1, "/images/bg/fondo_nivel 1.jpg", jugador);
      
      // Agregado Enemigos
      PVector[] puntos = {new PVector(50,100), new PVector(50,300)};
      nivelEnCurso.addEnemigo(new SoldadoNormal(50, 100, nivelEnCurso), puntos);
      PVector[] puntos2 = {new PVector(50,500), new PVector(50,300)};
      nivelEnCurso.addEnemigo(new SoldadoNormal(50, 500, nivelEnCurso), puntos2);
      PVector[] puntos3 = {new PVector(250,300), new PVector(50,300)};
      nivelEnCurso.addEnemigo(new SoldadoNormal(150, 300, nivelEnCurso), puntos3);
      nivelEnCurso.addEnemigo(new SoldadoNormal(125, 225, nivelEnCurso), null);
      nivelEnCurso.addEnemigo(new SoldadoNormal(125, 375, nivelEnCurso), null);
      
      // Paredes Lado noroeste
      nivelEnCurso.addPared(new Pared(75, 25, 50, 150));
      nivelEnCurso.addPared(new Pared(125, 125, 150, 50));
      nivelEnCurso.addPared(new Pared(175, 200, 100, 50));
      
      // Paredes Lado noreste
      nivelEnCurso.addPared(new Pared(75, 575, 50, 150));
      nivelEnCurso.addPared(new Pared(125, 475, 150, 50));
      nivelEnCurso.addPared(new Pared(175, 400, 100, 50));
      
      // Paredes centrales
      nivelEnCurso.addPared(new Pared(275, 300, 300, 50));
      nivelEnCurso.addPared(new Pared(275, 75, 50, 150));
      nivelEnCurso.addPared(new Pared(275, 525, 50, 150));
      
      // Paredes central-derechas
      nivelEnCurso.addPared(new Pared(425, 125, 150, 50));
      nivelEnCurso.addPared(new Pared(375, 200, 100, 50));
      nivelEnCurso.addPared(new Pared(425, 475, 150, 50));
      nivelEnCurso.addPared(new Pared(375, 400, 100, 50));
      
      // Paredes lateral derechas
      nivelEnCurso.addPared(new Pared(550, 25, 50, 100));
      nivelEnCurso.addPared(new Pared(525, 75, 50, 50));
      nivelEnCurso.addPared(new Pared(525, 200, 100, 50));
      nivelEnCurso.addPared(new Pared(475, 300, 100, 50));
      nivelEnCurso.addPared(new Pared(525, 400, 100, 50));
      nivelEnCurso.addPared(new Pared(525, 525, 50, 50));
      nivelEnCurso.addPared(new Pared(550, 575, 50, 100));
      
      jugador.setNivel(nivelEnCurso);
    break;
  }
  
  // Dibuja la interfaz en pantalla
  interfaz = new Interfaz();
}

// Libera los recursos de lo que no se va a usar
void limpiarPantalla() {
  nivelEnCurso = null;
  //jugador = null;
  interfaz = null;
  background(0);
}

void keyPressed() {
  if (key == ESC) exit();
  if (estadoJuego == MaquinaEstados.ESTADO_INICIO) {
    estadoJuego = MaquinaEstados.ESTADO_JUGANDO;
    inicio();
  }
  if ((estadoJuego == MaquinaEstados.ESTADO_GANADO || estadoJuego == MaquinaEstados.ESTADO_PERDIDO) && keyCode == ENTER) {
    exit();
  }
}

void mousePressed() {
  if (mousePressed && mouseButton == LEFT && estadoJuego == MaquinaEstados.ESTADO_JUGANDO) jugador.shoot();
}
