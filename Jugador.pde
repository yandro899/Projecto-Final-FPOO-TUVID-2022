class Jugador extends Persona {
  private int puntaje;
  private ArrayList<Arma> arsenal;
  private int armaEnUso;
  private PVector mira;
  
  public static final char MOV_UP = 'w';
  public static final char MOV_DOWN ='s';
  public static final char MOV_LEFT = 'a';
  public static final char MOV_RIGHT= 'd';
  
  public Jugador(int vida, int velocidad, Nivel nivel) {
    super(width/2, height/2, vida, velocidad, 30, 10, nivel);
    this.arsenal = new ArrayList<Arma>();
    // POR DEFECTO UNA PISTOLA
    this.arsenal.add(new Pistola(this));
    this.armaEnUso = 0;
    this.isPlayer = true;
  }
  
  public void display() {
    rectMode(CENTER);
    rect(this.posicion.x, this.posicion.y, this.ancho, this.alto);
    
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
  
  public void shoot() {
    Arma armaSeleccionada = seleccionarArma();
    armaSeleccionada.shootGun();
  }
  
  public Arma seleccionarArma() {
    return this.arsenal.get(this.armaEnUso);
  }
  
  public PVector direccionDisparo() {
    return this.mira.sub(this.posicion).normalize();
  }
  
  public void damage(int dano) {
    this.vida -= dano;
    if (this.vida <= 0) {
      estadoJuego = MaquinaEstados.ESTADO_PERDIDO;
    }
  }
  
}
