ArrayList<Cuadrado> tubos;
Pelota bird;
float UltimoPar = 0;
PVector G = new PVector(0, 0.5); 

void setup() {
  size(800, 600);
  tubos = new ArrayList<Cuadrado>();
  bird = new Pelota(100, height/2); 
}

void draw() {
  background(0);

  AgregarTubos();
  borrarTubos();
  
  for (int i = tubos.size() - 1; i >= 0; i--) {
    Cuadrado t = tubos.get(i);
    t.mover();
    t.mostrar();
    
    if (t.chocaCon(bird)) {
      println("perdiste por tocar un tubo");
      reiniciarJuego();
    }
  }

  bird.addfuerza(G);
  bird.mover();
  bird.mostrar();
  
  if (bird.pos.y > height || bird.pos.y < 0) {
     println("saliste de la pantalla");
     reiniciarJuego();
  }
}
void keyPressed() {
  if (key == ' ') {
    bird.saltar();
  }
}

void borrarTubos() {
  for (int i = tubos.size()-1; i >= 0; i--) {
    Cuadrado Aux = tubos.get(i);
    if (Aux.pos.x + Aux.ancho < 0) { 
      tubos.remove(i);
    }   
  }
}

void AgregarTubos() {
  float tActual = millis();
  float dt = tActual - UltimoPar;
  
  if (dt > 2000) { 

    float xInicial = width;
    tubos.add(new Cuadrado(xInicial, true));
    tubos.add(new Cuadrado(xInicial, false));
    
    UltimoPar = tActual;
  }
}

void reiniciarJuego() {
  bird = new Pelota(100, height/2);
  tubos.clear();
  UltimoPar = millis();
}

class Cuadrado {
  PVector pos;
  int ancho = 50;
  int alto;
  float velocidadX = 3;
  boolean esSuperior;

  Cuadrado(float P_X, boolean superior) {
    esSuperior = superior;
    
    int hueco = 150;
    int altoMinimo = 50;
    
    if (esSuperior) {
      alto = (int)random(altoMinimo, height - hueco - altoMinimo);
      pos = new PVector(P_X, alto / 2);
    } else {

      float altoSupAleatorio = random(altoMinimo, height - hueco - altoMinimo);
      
      alto = (int)(height - altoSupAleatorio - hueco);
      pos = new PVector(P_X, height - (alto / 2));
    }
  }

  void mostrar() {
    rectMode(CENTER);
    fill(30, 140, 30);
    stroke(0);
    strokeWeight(2);
    rect(pos.x, pos.y, ancho, alto);
  }

  void mover() {
    pos.x = pos.x - velocidadX;
  }
  boolean chocaCon(Pelota p) {
    float limIzquierda = pos.x - ancho / 2;
    float limDerecha = pos.x + ancho / 2;
    float limArriba = pos.y - alto / 2;
    float limAbajo = pos.y + alto / 2;

    if (p.pos.x + p.r > limIzquierda && 
        p.pos.x - p.r < limDerecha && 
        p.pos.y + p.r > limArriba && 
        p.pos.y - p.r < limAbajo) {
      return true;
    }
    return false;
  }
}

class Pelota {
  PVector pos;
  PVector vel;
  PVector acel;
  float r = 15.0;
  color c = color(255, 215, 0);

  Pelota(float x, float y) {
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    acel = new PVector(0, 0);
  }

  void addfuerza(PVector fuerza) {
    acel.add(fuerza);
  }

  void saltar() {
    vel.y = -8;
  }

  void mover() {
    vel.add(acel);
    pos.add(vel);  
    acel.mult(0); 
    
    if (vel.y > 10) vel.y = 10;
  }

  void mostrar() {
    fill(c);
    stroke(0);
    strokeWeight(2);
    circle(pos.x, pos.y, r * 2);
  }
}
