class SoldadoNormal extends Enemigo {
  
  public SoldadoNormal(float x, float y, Nivel nivel) {
    // super ( posX, posY, vida, velocidad, alto, ancho, nivel, puntos, arma)
    super(x, y, 2, 6, 30, 10, nivel, 400, new Pistola());
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
    this.arma.display();
  }
  
  public void move() {
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
