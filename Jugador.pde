/** Clase Jugador:
Es la clase de la que el jugador tiene el control.
*/

class Jugador extends Persona {
  private int puntaje;              // Puntaje total acumulado
  private ArrayList<Arma> arsenal;  // Arsenal de armas de las que el jugador dispone
  private int armaEnUso;            // Arma que el jugador esta usando actualmente
  private PVector mira;             // Mira del jugador (dependiente del mouse)
  
  // Controles de movimiento
  public static final char MOV_UP = 'w';
  public static final char MOV_DOWN ='s';
  public static final char MOV_LEFT = 'a';
  public static final char MOV_RIGHT= 'd';
  
  /** Constructor parametrizado */
  public Jugador(int vida, int velocidad, Nivel nivel) {
    super(width/2, height/2, vida, velocidad, 30, 10, nivel);
    this.arsenal = new ArrayList<Arma>();
    // POR DEFECTO UNA PISTOLA
    this.arsenal.add(new Pistola(this));
    this.armaEnUso = 0;
    this.isPlayer = true;
    this.puntaje = 0;
  }
  
  /** Dibuja el jugador (y la mira) en pantalla */
  public void display() {
    rectMode(CENTER);
    rect(this.posicion.x, this.posicion.y, this.ancho, this.alto);
    
    // Dibujar la mira
    this.mira = new PVector(mouseX, mouseY);
    noFill();
    stroke(#ff0000);
    strokeWeight(3);
    circle(this.mira.x, this.mira.y, 20);
    line(this.mira.x, this.mira.y-15, this.mira.x,this.mira.y+15);
    line(this.mira.x-15, this.mira.y, this.mira.x+15, this.mira.y);
    stroke(#000000);
    strokeWeight(1);
    fill(255);
    
    this.arsenal.get(this.armaEnUso).display();
  }
  
  // TODO: Pulir movimiento
  /** Movimiento del jugador */
  public void move() { 
    if (keyPressed) {
      switch (key) {
        case MOV_UP:
          this.posicion.add(0, -this.magVelocidad);
          if (this.posicion.y<0) this.posicion.y = 0;
          break;
        case MOV_DOWN:
          this.posicion.add(0, this.magVelocidad);
          if (this.posicion.y>height) this.posicion.y = height;
          break;
        case MOV_LEFT:
          this.posicion.add(-this.magVelocidad, 0);
          if (this.posicion.x<0) this.posicion.x = 0;
          break;
        case MOV_RIGHT:
          this.posicion.add(this.magVelocidad, 0);
          if (this.posicion.x>width) this.posicion.x = width;
      }
    }
    this.arsenal.get(this.armaEnUso).setPosicion(this.posicion.x, this.posicion.y);
    this.collider.setPosicion(this.posicion.x, this.posicion.y);
  }
  
  /** Accion de disparo del jugador */
  public void shoot() {
    // POLIMORFISMO
    Arma armaSeleccionada = seleccionarArma();
    armaSeleccionada.shootGun();
  }
  
  /** Selecciona el arma */
  public Arma seleccionarArma() {
    return this.arsenal.get(this.armaEnUso);
  }
  
  /** Entrega el vector direccion del disparo */
  public PVector direccionDisparo() {
    return this.mira.sub(this.posicion).normalize();
  }
  
  /** El jugador recibió daño */
  public void damage(int dano) {
    this.vida -= dano;
    if (this.vida <= 0) {
      estadoJuego = MaquinaEstados.ESTADO_PERDIDO;
    }
  }
  
  /** Metodos accesores */
  public int getPuntaje() {
    return this.puntaje;
  }
  
  public void incPuntaje(int puntaje) {
    this.puntaje += puntaje;
  }
  
}
