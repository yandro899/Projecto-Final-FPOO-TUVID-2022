class RectCollider extends GameObject{
  private float alto;
  private float ancho;
  private boolean collideOn;
  
  public RectCollider(float x, float y, float alto, float ancho, boolean active) {
    super(x, y);
    this.alto = alto;
    this.ancho = ancho;
    this.collideOn = active;
  }
  
  public boolean collideWith(RectCollider collider) {
    if (!this.collideOn) return false;
    if (this.posicion.x-ancho/2 > collider.getPosicion().x-getAncho()/2) return false;
    if (this.posicion.x+ancho/2 < collider.getPosicion().x+getAncho()/2) return false;
    if (this.posicion.y-alto/2 > collider.getPosicion().y+getAlto()/2) return false;
    if (this.posicion.y+alto/2 < collider.getPosicion().y-getAlto()/2) return false;
    return true;
  }
  
  public boolean collideWith(CircleCollider circle){
    if (!this.collideOn) return false;
    
    PVector nearestPoint = new PVector(circle.getPosicion().x, circle.getPosicion().y);
    
    if(nearestPoint.x < this.posicion.x-this.ancho/2){
      nearestPoint.x = this.posicion.x-this.ancho/2;
    }
    
    if(nearestPoint.x > this.posicion.x+this.ancho/2){
      nearestPoint.x = this.posicion.x+this.ancho/2;
    }
    
    if(nearestPoint.y < this.posicion.y-this.alto/2){
      nearestPoint.y = this.posicion.y-this.alto/2;
    }
    
    if(nearestPoint.y > this.posicion.y+this.alto/2){
      nearestPoint.y = this.posicion.y+this.alto/2;
    }
    
    float distance = nearestPoint.dist(circle.getPosicion());
    if(distance <= circle.getRadius()) return true;
    else return false;
  }
  
  public void display() {
    fill(#ffffff);
    rect(this.posicion.x, this.posicion.y, this.ancho, this.alto);
  }
  
  // ----- Metodos accesores -----
  public float getAncho() {
    return this.ancho;
  }
  
  public float getAlto() {
    return this.alto;
  }
  
  public boolean isCollideActive() {
    return this.collideOn;
  }
  
  public void setAlto(float alto) {
    this.alto = alto;
  }
  
  public void setAncho(float ancho) {
    this.ancho = ancho;
  }
  
  public void setCollideActive(boolean active) {
    this.collideOn = active;
  }
  
}
