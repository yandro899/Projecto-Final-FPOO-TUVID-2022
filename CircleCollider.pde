class CircleCollider extends GameObject{
  private float radius;
  private boolean collideOn;
  
  public CircleCollider(float x, float y, float radius, boolean active) {
    super(x, y);
    this.radius = radius;
    this.collideOn = active;
  }
  
  public boolean collideWith(CircleCollider collider) {
    if (!this.collideOn) return false;
    
    float distancia = this.posicion.dist(collider.getPosicion());
    
    if (distancia < this.radius + collider.getRadius()) return true;
    else return false;
  }
  
  public boolean collideWith(RectCollider rectangle){
    if (!this.collideOn) return false;
    
    PVector nearestPoint = new PVector(this.posicion.x, this.posicion.y);
    
    if(nearestPoint.x < rectangle.getPosicion().x-rectangle.getAncho()/2){
      nearestPoint.x = rectangle.getPosicion().x-rectangle.getAncho()/2;
    }
    
    if(nearestPoint.x > rectangle.getPosicion().x+rectangle.getAncho()/2){
      nearestPoint.x = rectangle.getPosicion().x+rectangle.getAncho()/2;
    }
    
    if(nearestPoint.y < rectangle.getPosicion().y-rectangle.getAlto()/2){
      nearestPoint.y = rectangle.getPosicion().y-rectangle.getAlto()/2;
    }
    
    if(nearestPoint.y > rectangle.getPosicion().y+rectangle.getAlto()/2){
      nearestPoint.y = rectangle.getPosicion().y+rectangle.getAlto()/2;
    }
    
    
    float distance = nearestPoint.dist(this.posicion);
    if(distance <= this.radius) return true;
    else return false;
  }
  
  public void display() {
    fill(#ffffff);
    circle(this.posicion.x, this.posicion.y, this.radius*2);
  }
  
  // ----- Metodos accesores -----
  public float getRadius() {
    return this.radius;
  }
  
  public boolean isCollideActive() {
    return this.collideOn;
  }
  
  public void setRadius(float radius) {
    this.radius = radius;
  }
  
  public void setCollideActive(boolean active) {
    this.collideOn = active;
  }
  
}
