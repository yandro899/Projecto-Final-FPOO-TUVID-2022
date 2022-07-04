/** Clase Jugador:
Es la clase de la que el jugador tiene el control.
*/

class Jugador extends Persona {
  private int puntaje;              // Puntaje total acumulado
  private ArrayList<Arma> arsenal;  // Arsenal de armas de las que el jugador dispone
  private int armaEnUso;            // Arma que el jugador esta usando actualmente
  private PVector posicionAnt;
  private AnimatedSprite [] aniMov;
  
  // Controles de movimiento
  public static final char MOV_UP = 'w';
  public static final char MOV_DOWN ='s';
  public static final char MOV_LEFT = 'a';
  public static final char MOV_RIGHT= 'd';
  
  /** Constructor parametrizado */
  public Jugador(int vida, int velocidad, Nivel nivel) {
    super(width/2, height/2, vida, velocidad, 40, 40, nivel);
    this.arsenal = new ArrayList<Arma>();
    // POR DEFECTO UNA PISTOLA
    this.arsenal.add(new Pistola(this));
    this.armaEnUso = 0;
    this.isPlayer = true;
    this.puntaje = 0;
    this.posicionAnt = this.posicion.copy();
    this.initializeAnims();
  }
  
  /** Constructor parametrizado */
  public Jugador(float x, float y, int vida, int velocidad, Nivel nivel) {
    super(x, y, vida, velocidad, 40, 40, nivel);
    this.arsenal = new ArrayList<Arma>();
    // POR DEFECTO UNA PISTOLA
    this.arsenal.add(new Pistola(this));
    this.armaEnUso = 0;
    this.isPlayer = true;
    this.puntaje = 0;
    this.posicionAnt = this.posicion.copy();
    this.initializeAnims();
  }
  
  /** Dibuja el jugador (y la mira) en pantalla */
  public void display() {
    
    // DEBUG: Ver colision jugador
    //this.collider.display();
    
    for (int i=0; i<this.aniMov.length; i++) {
      this.aniMov[i].displaySprite();
      //println(i + " " + this.aniMov[i].isDisplay());
    }
    
    // Dibujar la mira (posicion del mouse)
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
    
    for (int i=0; i<this.aniMov.length; i++) {
        this.aniMov[i].animSprite(false);
      }
      
    if (keyPressed) {
      // Guarda la posicion anterior. Detecta un movimiento un instante anterior
      if (!this.posicion.equals(this.posicionAnt))
        this.posicionAnt = new PVector(this.posicion.x, this.posicion.y);
      
      for (int i=0; i<this.aniMov.length; i++) {
        this.aniMov[i].setDisplay(false);
      }
        
      switch (key) {
        case MOV_UP:
          this.posicion.add(0, -this.magVelocidad);
          this.aniMov[0].setDisplay(true);
          this.aniMov[0].animSprite(true);
          if (this.posicion.y<Interfaz.altoInterfaz) this.posicion.y = Interfaz.altoInterfaz;
          break;
        case MOV_DOWN:
          this.posicion.add(0, this.magVelocidad);
          this.aniMov[1].setDisplay(true);
          this.aniMov[1].animSprite(true);
          if (this.posicion.y>height) this.posicion.y = height;
          break;
        case MOV_LEFT:
          this.posicion.add(-this.magVelocidad, 0);
          this.aniMov[2].setDisplay(true);
          this.aniMov[2].animSprite(true);
          if (this.posicion.x<0) this.posicion.x = 0;
          break;
        case MOV_RIGHT:
          this.posicion.add(this.magVelocidad, 0);
          this.aniMov[3].setDisplay(true);
          this.aniMov[3].animSprite(true);
          if (this.posicion.x>width) this.posicion.x = width;
          break;
        default:
          this.aniMov[3].setDisplay(true);
      }
    }
    this.collider.setPosicion(this.posicion.x, this.posicion.y);
    chequeoParedesColision(key);
    
    this.arsenal.get(this.armaEnUso).setPosicion(this.posicion.x, this.posicion.y);
    
    for (int i=0; i<this.aniMov.length; i++) {
        this.aniMov[i].setPosicion(this.posicion.x, this.posicion.y);
      }
  }
  
  private void initializeAnims() {
    AnimatedSprite[] aniMov = {new AnimatedSprite("/images/tanque/tanque_mov_up.png", 40, 40, this.posicion.x, this.posicion.y, 2, 8, true, false),
                               new AnimatedSprite("/images/tanque/tanque_mov_down.png", 40, 40, this.posicion.x, this.posicion.y, 2, 8, false, false),
                               new AnimatedSprite("/images/tanque/tanque_mov_left.png", 40, 40, this.posicion.x, this.posicion.y, 2, 8, false, false),
                               new AnimatedSprite("/images/tanque/tanque_mov_right.png", 40, 40, this.posicion.x, this.posicion.y, 2, 8, false, false)};
    this.aniMov = aniMov;
  }
  
  /** Chequeo colision paredes */
  private void chequeoParedesColision(char direccion) {
    for (int i=0; i<this.onNivel.getParedes().size(); i++) {
      Pared paredAnalizada = this.onNivel.getParedes().get(i);
      
      switch (direccion) {
        case MOV_UP:
          if (paredAnalizada.getCollider().collideWith(this.collider))
          this.posicion = new PVector(this.posicion.x,
            paredAnalizada.getPosicion().y+paredAnalizada.getCollider().getAlto()/2+this.alto/2+1);
          break;
        case MOV_DOWN:
          if (paredAnalizada.getCollider().collideWith(this.collider))
          this.posicion = new PVector(this.posicion.x,
            paredAnalizada.getPosicion().y-paredAnalizada.getCollider().getAlto()/2-this.alto/2-1);
          break;
        case MOV_LEFT:
          if (paredAnalizada.getCollider().collideWith(this.collider))
          this.posicion = new PVector(paredAnalizada.getPosicion().x+paredAnalizada.getCollider().getAncho()/2+this.ancho/2+1,
          this.posicion.y);
          break;
        case MOV_RIGHT:
          if (paredAnalizada.getCollider().collideWith(this.collider))
          this.posicion = new PVector(paredAnalizada.getPosicion().x-paredAnalizada.getCollider().getAncho()/2-this.ancho/2-1,
          this.posicion.y);
      } 
    }
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
  
  /** El jugador recibió daño */
  public void damage(int dano) {
    this.vida -= dano;
    if (this.vida <= 0) {
      estadoJuego = MaquinaEstados.ESTADO_PERDIDO;
      puntajeFinal();
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
