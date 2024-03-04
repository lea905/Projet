final int NBCOL=10; //nombre de colonnes de la grille //<>//
final int NBLIG=10; //nombre de lignes de la grille
final int TAILLECASE=64; //taille d'une case en pixels
final int NBFIG=12; //nombre de figures (max 12)
Case c1 = new Case();
Case c2 = new Case();
int score=0;
boolean modePause=false;
int debutPause=0;
int debutTemps=0;
int tempsMax=30;
boolean fin=false;

PImage tabimages[]=new PImage[12];
Grille g;

void settings() {
 size(TAILLECASE*NBCOL+200, TAILLECASE*NBLIG);
}

void setup() {
  PFont font = createFont("Arial", 20);
  textFont(font);
  g=new Grille();
  g.initGrille();
  g.afficheConsole();
  chargerImages();
  g.dessin();
  c1=null;
  c2=null;
}

void draw() {
  if (!fin) {
    if (!modePause) {
      if (g.existeAlignement(true)) {
        modePause=true;
        debutPause=millis();
      }
    } else {
      if (millis()-debutPause>=1000) {
        modePause=false;
        debutTemps=millis();
        score=score+1+(g.supprimeCasesMarquees()-3)*5;
      }
    }

    if (!modePause && !g.estJouable()) {
      modePause=true;
      g.toutMarquer();
      debutPause=millis();
    }

    if ((millis()-debutTemps)/1000>tempsMax) {
      fin=true;
      println("test");
    }
  }
  g.dessin();
}


void mousePressed() {
  if (c1==null && mouseY>=0 && mouseY<=TAILLECASE*NBLIG && mouseX>=0 && mouseX<=TAILLECASE*NBCOL) {
    c1=g.tab[mouseY/TAILLECASE][mouseX/TAILLECASE];
    c1.etat=2;
  } else if (c1!=null && c2==null && mouseY>=0 && mouseY<=TAILLECASE*NBLIG && mouseX>=0 && mouseX<=TAILLECASE*NBCOL) {
    c2=g.tab[mouseY/TAILLECASE][mouseX/TAILLECASE];
    c2.etat=2;
    //on verifie que c1 et c2 sont voisines
    if (abs(c1.lig-c2.lig)==1 && c1.col==c2.col || abs(c1.col-c2.col)==1 && c1.lig==c2.lig) {
      c1.echangeIdCase(c2);
      //on vérifie s'il y a un alignement sinon on rééchange
      if (!g.existeAlignement(false)) {
        c1.echangeIdCase(c2);
      }
    }
    c1.etat=0;
    c2.etat=0;
    c1=null;
    c2=null;
  }
}



void chargerImages() {
  tabimages[0]=loadImage("chauvesouris.png");
  tabimages[1]=loadImage("coccinelle.png");
  tabimages[2]=loadImage("cochon.png");
  tabimages[3]=loadImage("dauphin.png");
  tabimages[4]=loadImage("elephant.png");
  tabimages[5]=loadImage("grenouille.png");
  tabimages[6]=loadImage("lion.png");
  tabimages[7]=loadImage("panda.png");
  tabimages[8]=loadImage("pigeon.png");
  tabimages[9]=loadImage("poisson.png");
  tabimages[10]=loadImage("poussin.png");
  tabimages[11]=loadImage("serpent.png");

  for (int i=0; i<tabimages.length; i++) {
    tabimages[i].resize(TAILLECASE, TAILLECASE);
  }
}
