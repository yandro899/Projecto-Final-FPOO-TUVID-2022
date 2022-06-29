class Pistola extends Arma {
  
  public Pistola() {
    super(35, 1, 15);
  }
  
  public Pistola(Persona portador) {
    super(35, 1, 15, portador);
  }
  
  public void shootGun() {
    for(int i=0; i<this.municionMax; i++) {
      if (!this.municionCargada.get(i).isShooted()) {
        this.municionCargada.get(i).shootBullet();
        break;
      }
    }
  }
  
  public void reload() {
    
  }
  
  public void display() {
    square(this.posicion.x, this.posicion.y, 10);
    //println(this.municionCargada.get(0).getPosicion().x + " " + this.municionCargada.get(0).getPosicion().y);
    for(int i=0; i<this.municionMax; i++) {
      this.municionCargada.get(i).display();
    }
    this.chequeoBalas();
  }
  
  @Override
  public void chequeoBalas() {
    for (int i=0; i<this.municionMax; i++) {
      if(!this.municionCargada.get(i).getCollider().collideWith(this.portador.getNivel().getZonaJugable()) ||
      this.municionCargada.get(i).impactSomeEnemy()) {
        this.municionCargada.get(i).unShoot();
        
        // Vuelve la bala y su hitbox al cargador al salir del mapa
        this.municionCargada.get(i).setPosicion(this.posicion.x, this.posicion.y);
        this.municionCargada.get(i).getCollider().setPosicion(this.posicion.x, this.posicion.y);
      }
    }
  }
  
}
