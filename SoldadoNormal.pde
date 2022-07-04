/** Clase SoldadoEnemigo:
Uno de los enemigos del juego. Es el mas debil de todos
*/

class SoldadoNormal extends Enemigo {
  private AnimatedSprite [] aniMov;
  
  /** Constructor parametrizado */
  public SoldadoNormal(float x, float y, Nivel nivel) {
    // super ( posX, posY, vida, velocidad, alto, ancho, nivel, puntos, arma)
    super(x, y, 2, 2, 40, 40, nivel, 400, new Pistola());
    this.arma.setPortador(this);
    this.collider = new RectCollider(this.posicion.x, this.posicion.y, alto, ancho, true);
    initializeAnims();
  }
  
  /** Disparo de esta clase */
  public void shoot() {
    this.arma.shootGun();
  }
  
  /** Dibujo en pantalla de este enemigo */
  public void display() {
    
    for (int i=0; i<this.aniMov.length; i++) {
        this.aniMov[i].displaySprite();
    }
    
    
    
    //fill(#00ff00);
    //rect(this.posicion.x, this.posicion.y, this.ancho, this.alto);
    //fill(255);
    this.arma.display();
  }
  
  /** Movimiento de este enemigo */
  public void move() {
    
    for (int i=0; i<this.aniMov.length; i++) {
        this.aniMov[i].animSprite(false);
    }
    
    // Actualiza la mira del enemigo
    this.mira = this.onNivel.getJugador().getPosicion().copy();
    
    // Condicion de disparo (Un disparo por segundo)
    if (frameCount%60==0) this.shoot();
    
    // Si no hay puntos de movimiento, se queda donde esta.
    if (this.recorrido==null || this.recorrido.size() == 0) return;
    
    // SE LLEGA AQUI SI HAY UN PUNTO DE RECORRIDO
    
    for (int i=0; i<this.aniMov.length; i++) {
        this.aniMov[i].setDisplay(false);
    }
    
    // Hacia abajo
    if (this.velocidad.normalize().equals(new PVector(0, -1))) {
      this.aniMov[0].animSprite(true);
      this.aniMov[0].setDisplay(true);
    }
    else if (this.velocidad.normalize().equals(new PVector(0, 1))) {
      this.aniMov[1].animSprite(true);
      this.aniMov[1].setDisplay(true);
    }
    else if (this.velocidad.normalize().equals(new PVector(-1, 0))) {
      this.aniMov[2].animSprite(true);
      this.aniMov[2].setDisplay(true);
    }
    else if (this.velocidad.normalize().equals(new PVector(1, 0))) {
      this.aniMov[3].animSprite(true);
      this.aniMov[3].setDisplay(true);
    }
    
    // Si no tiene velocidad y no esta en ningun punto, se mueve al punto 1
    if (this.velocidad.mag()==0 && !this.enAlgunPunto()) {
      this.velocidad = PVector.sub(this.recorrido.get(0), this.posicion).normalize().mult(this.magVelocidad);
      return;
    }
    
    // Si solo tiene un punto, se mueve hasta ese punto y se queda quieto.
    if (this.recorrido.size() == 1) {
      // Si llego a ese punto, se pone su velocidad en 0
      if (this.enAlgunPunto()) this.velocidad = new PVector();
      return;
    }
    
    // LLEGA AQUI SI HAY 2 o MAS NODOS DE RECORRIDO
    
    // Analiza punto por punto de recorrido si el enemigo esta dentro de su radio.
    // Si esta dentro de el, entonces su direccion cambia al otro punto.
    // Si no, no hace nada.
    for (int i=0; i<this.recorrido.size(); i++) {
      if(this.posicion.dist(this.recorrido.get(i))<20) {
        // Esto es para que cuando el enemigo llegue al punto final, vuelva al primer punto del recorrido
        if (i >= this.recorrido.size()-1) {
          this.velocidad = PVector.sub(this.recorrido.get(0), this.posicion).normalize().mult(this.magVelocidad);
        }
        else 
          this.velocidad = PVector.sub(this.recorrido.get(i+1), this.posicion).normalize().mult(this.magVelocidad);
        break;
      }
    }
    
    this.posicion.add(this.velocidad);
    this.collider.setPosicion(this.posicion.x, this.posicion.y);
    this.arma.setPosicion(this.posicion.x, this.posicion.y);
    for (int i=0; i<this.aniMov.length; i++) {
        this.aniMov[i].setPosicion(this.posicion.x, this.posicion.y);
     }
  }
  
  private void initializeAnims() {
    AnimatedSprite[] aniMov = {new AnimatedSprite("/images/enemigoComun/Enemy_Normal_Move_Up.png", 40, 40, this.posicion.x, this.posicion.y, 2, 8, true, false),
                               new AnimatedSprite("/images/enemigoComun/Enemy_Normal_Move_Down.png", 40, 40, this.posicion.x, this.posicion.y, 2, 8, false, false),
                               new AnimatedSprite("/images/enemigoComun/Enemy_Normal_Move_Left.png", 40, 40, this.posicion.x, this.posicion.y, 2, 8, false, false),
                               new AnimatedSprite("/images/enemigoComun/Enemy_Normal_Move_Right.png", 40, 40, this.posicion.x, this.posicion.y, 2, 8, false, false)};
    this.aniMov = aniMov;
  }
  
  /** Accion de recibir daño */
  public void damage(int dano) {
    this.vida -= dano;
    if (this.vida <= 0) {
      this.isDead = true;
      this.getCollider().setCollideActive(false);
      this.arma.getPortador().getNivel().getJugador().incPuntaje(this.puntos);
    }
  }
}
