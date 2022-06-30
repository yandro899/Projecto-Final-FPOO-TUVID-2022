class SoldadoNormal extends Enemigo {
  
  public SoldadoNormal(float x, float y, Nivel nivel) {
    // super ( posX, posY, vida, velocidad, alto, ancho, nivel, puntos, arma)
    super(x, y, 2, 2, 30, 10, nivel, 400, new Pistola());
    this.arma.setPortador(this);
    this.collider = new RectCollider(this.posicion.x, this.posicion.y, alto, ancho, true);
  }
  
  public void shoot() {
    this.arma.shootGun();
  }
  
  public void display() {
    fill(#00ff00);
    rect(this.posicion.x, this.posicion.y, this.ancho, this.alto);
    fill(255);
    //println(this.posicion.x + " " + this.posicion.y);
    this.arma.display();
  }
  
  public void move() {
    // Si no tiene velocidad y no esta en ningun punto, se mueve al punto 1
    if (this.velocidad.mag()==0 && !this.enAlgunPunto()) {
      this.velocidad = PVector.sub(this.recorrido.get(0), this.posicion).normalize().mult(this.magVelocidad);
      //this.velocidad = this.recorrido.get(0).sub(this.posicion).normalize().mult(this.magVelocidad);
      println(this.recorrido.get(0).x + " " + this.recorrido.get(0).y);
    }
    
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
    if (frameCount%60==0) this.shoot();
  }
  
  public PVector direccionDisparo() {
    PVector disparo = new PVector(this.onNivel.getJugador().getPosicion().x, this.onNivel.getJugador().getPosicion().y);
    return disparo.sub(this.posicion).normalize();
  }
  
  public void damage(int dano) {
    this.vida -= dano;
    if (this.vida <= 0) {
      this.isDead = true;
      this.getCollider().setCollideActive(false);
    }
  }
}
