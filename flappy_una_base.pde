ArrayList<Cuadrado> tubos;
Pelota bird; float ultimaPar = 0;
PVector G = newPVector(0,2);

void setup(){  size(800,600);
  tubos = new ArrayList<Cuadrado>();
  bird = new Pelota(100, height/2);
}
void draw(){
  background(0);
  AgregarTubos();
  bird.addfuerza(G);
  bird.mover();
  borrarTubos();
  
  for(Cuadrado t : tubos){
    t.mover();
    t.mostrar();
  }
  bird.mostrar();
}

void borrarTubos(){
  for(int i = tubos.size()-1; i >= 0; i--){
    Cuadrado Aux = tubos.get(i);
    if(Aux.pos.x < 0){
      tubos.remove(i);}   
  }
}

void AgregarTubos(){
  float tActual = millis();
  float dt = tActual - UltimoPar;
    if(dt > 5000){
      tubos.add(new Cuadrado());
      tubos.add
      UltimoPar = tActual;
    }
}
