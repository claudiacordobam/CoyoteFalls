float x1, y1, x2, y2; // Posició del primer i segon coiot
float g=9.80; // Acceleració de la gravetat
float delta_t = 0.025; // Increments de temps entre els que es fan els fotogrames
float vx1, vx2, vy1, vy2; // Velocitats de cada coiot en cadascun dels eixos x i y
float velocitatHoritzontal = 15; // Generem una variable per la velocitat horitzontal per assignar-la posteriorment a vx1 i vx2
PImage coiot; //Generem una variable PImage per posteriorment importar el PNG del coiot
import ddf.minim.*; // Cal importar la biblioteca Minim des de Sketch > Importar Biblioteca
Minim minim; // Generem una variable minim que ens permetrà carregar l'arxiu de so amb la biblioteca Minim
AudioPlayer musica; // Generem una variable del tipus AudioPlayer anomenada musica amb la qual treballarem per afegir música a l'animació

    
void setup() {
  size(1000, 600);
  stroke(10); // Amplada de les línies = 10 píxels
  textSize(30); // Definim l'alçada del text = 30 píxels
  coiot = loadImage("coiot.png");
  imageMode(CENTER); // Centrem les imatges per tal que es comportin com l'elipse
  minim = new Minim(this); // Carreguem el sistema d'àudio de Minim
  musica = minim.loadFile("music.wav"); // Importem el fitxer des de la carpeta Data
  musica.loop(); // Fem que la música importada es reprodeixi en bucle
  posicioInicial(); //Definim els paràmetres inicials
} 
 
void draw() { 
  background(217, 248, 255); // Canviem el color de fons per un blau cel en RGB per simular el cel

  // Dividir la pantalla i pintar els penyasegats
  line(width/2, 0, width/2, height); // Dibuixem la línia que divideix la finestra de treball en 2
  fill(125, 64, 52);  // Pintem els penyassegats de color marró, com si fos una muntanya de terra, amb el codi en RGB
  rect(0, 295, 150, height); // Penyassegat 1, amb inici a x= 0, y = 300
  rect(width/2, 295, 150, height); // Penyassegat 2, amb inici a x = width/2 (meitat de la finestra de treball), y = 300
  
  // Condicions inicials del moviment
  //Com és un MRU, posem la velocitat horitzontal com a paràmetre fixe:
  vx1 = velocitatHoritzontal; 
  vx2 = velocitatHoritzontal;
   
  // Càlcul de les velocitats de cada coiot
  if (x1 > width/ 2 - 250) { // El coiot 1 es deté en l'eix horitzontal quan està flotant a l'aire però després d'haver recorregut un tram, tal com passa als dibuixos animats
    vy1 = vy1 + g * delta_t; // Com es tracta d'un moviment de caiguda lliure pel coiot 1, fem el càlcul d'un MRUA en l'eix vertical
    vx1 = 0; // En tractar-se d'un moviment de caiguda lliure, la velocitat en l'eix X passa a ser zero
  }

  if (x2 > width/ 2 + 159) { // Observem si el coiot 2 ha sortit del penyassegat 
    vy2 = vy2 + g * delta_t; // Fem el nou càlcul de velocitat de l'eix vertical mitjançant un MRUA
  }
  
  // Càlcul de les posicions de cada coiot
  if (y1 < height - 25) { // El bloc de codi s'executarà sempre que y1 sigui més petita que l'alçada - 25 píxels (per tal de donar la sensació que el coiot frena en arribar al terra, és a dir, la part baixa de la finestra de treball)
    x1 = x1 + vx1 * delta_t; // Calculem la nova posició d'x1 en base a la posició prèvia més la suma de la seva velocitat multiplicada pel temps (multiplicant-ho pel temps, podem saber quants píxels s'ha desplaçat). Passa el mateix amb y1, x2 i y2
    y1 = y1 + vy1 * delta_t;
  }

  if (y2 < height - 25) { // El bloc de codi s'executarà sempre que y2 sigui més petita que l'alçada - 25 píxels (per tal de donar la sensació que el coiot frena en arribar al terra, és a dir, la part baixa de la finestra de treball)
    x2 = x2 + vx2 * delta_t;
    y2 = y2 + vy2 * delta_t;
  }
  // En ambdós casos, el moviment observat és el que s'espera, ja que el coiot 1 avança un tram i després cau en caiguda lliure, i el coiot 2 cau fent una paràbola
  
  // Dibuixar cada coiot en la posició correcta
  image(coiot, x1, y1, 40, 50); // Dibuixem el coiot 1 fent referència a l'arxiu d'imatge que hem carregat, a les posicions inicials i a la mida de la imatge
  image(coiot, x2, y2, 40, 50); // Dibuixem el coiot 2 fent referència a l'arxiu d'imatge que hem carregat, a les posicions inicials i a la mida de la imatge
  
   // Dibuixar el meu nom quan es presiona la tecla SPACE
  draw_name(); // Fem la crida al bloc de codi draw_name() perquè s'executi
  }

void posicioInicial(){ // Amb void posicioInicial(), estem definint tots els paràmetres en els seus valors inicials
  x1 = 30;
  y1 = 270;
  x2 = width/2 + 30;
  y2 = 270;

  vx1 = velocitatHoritzontal;
  vx2 = velocitatHoritzontal;
  vy1 = 0;
  vy2 = 0;
}

void keyPressed() {
  if (key == 'r' || key == 'R') { // Quan la t ecla r o R està apretada, es compleix la condició per executar el bloc de codi posicioInicial() i reiniciar l'animació
    posicioInicial();
  }
 }
  
void draw_name() {
    if (keyPressed) {
      if (key == 32) { // El codi ASCII de la tecla SPACE és 32
        fill(140,199,255); // Definim els colors del rectangle de fons
        rect(50, 50, 300, 75); // Dibuixem el rectangle de fons del meu nom
        fill(0, 26, 48); // Definim els colors del text en RGB
        text("Claudia Córdoba", 100, 100); // Dibuixem el text, en aquest cas, el meu nom
    }
  }
}
