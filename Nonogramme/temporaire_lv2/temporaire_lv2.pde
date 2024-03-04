Grille g; //<>//
int nblig;
int nbcol;
int nbligjouable;
int nbcoljouable;
int figure[][];
int nb_couleurs;
int tailleMenu=75;
int largeurGrille;
int hauteurGrille = 675;
int tailleC = 50;
String f[] = {"C_chien_7x10.txt", "C_oiseau_6x8.txt",
  "C_parapluie_5x5.txt", "NB_ancre_5x9.txt",
  "NB_avion_5x5.txt", "NB_chameau_5x5.txt"};
String fichierAct = f[4];
int couleurAct=1;
int maxLig = 0;
int maxCol = 0;
PImage imgAcc;
boolean cliquee = false;
int mode = 0;
int tabCouleurP3[];
int nb_colors=6;
color tabCouleurP4[] =  new color[nb_colors];
String nomFichierU;
boolean initmode3 = false; //sert a savoir quand le mode 3 Manuel doit etre initialisé
boolean initManueljeu = false;
boolean change = false;


void setup() {
  PFont font = createFont("Arial", 20);
  size (1200, 850);
  imgAcc = loadImage("Nonogramme2.png");
  image(imgAcc, 0, 0);
  
}

void draw() {
  PFont font = createFont("Arial", 20);
  if (cliquee == true && (mode==1 || mode == 2)) {
    g.dessin(fichierAct);
  }
  if (change == true && mode==1) {
    afficheMenu();
    textSize(20);
    text("Couleurs", 375, 45);
    textSize(28);
    text("Classique", 100, 45);
    textSize(20);
    text("Manuel", 650, 45);
    text("Importation du jeu", width-300, 45);
    textSize(18);
    text("NB - Ancre ", (width/4)*3, 410);
    text("NB - Avion", (width/4)*3, 435);
    text("NB - Chameau", (width/4)*3, 460);
    text("Touche SHIFT pour vérifier la grille", (width/4)*3, 510);
    g = new Grille();
    chargerFichier(fichierAct);
    tailleGrilletotale();
    g.initG();
    g.remplissage_grille();
    g.dessin(fichierAct);
    change = false;
  }
  if (mode==2) {
    Palette2();
  }
  if (change==true && mode==2) {
    afficheMenu();
    textSize(28);
    text("Couleurs", 375, 45);
    textSize(20);
    text("Classique", 100, 45);
    textSize(20);
    text("Manuel", 650, 45);
    text("Importation du jeu", width-300, 45);
    textSize(18);
    text("Couleurs - Chien ", (width/4)*3, 410);
    text("Couleurs - Oiseau", (width/4)*3, 435);
    text("Couleurs - Parapluie", (width/4)*3, 460);
    text("Touche SHIFT pour vérifier la grille", (width/4)*3, 510);
    // partie jeu utilisateur à gauche
    g = new Grille();
    chargerFichier(fichierAct);
    tailleGrilletotale();
    largeurGrille=nbcol*tailleC;
    g.initG();
    g.remplissage_grille();
    g.dessin(fichierAct);
    change = false;
  }
  if (mode==3){
    creaManuel();
  }
  if(mode==4){
    afficheImportation();
  }
}

void keyPressed() {
  if (keyPressed) {
    if (key=='1') {
      initmode3 = false;
      initManueljeu = false;
      mode = 1;
      afficheClassique();
    }
    if (key == '2') {
      initmode3 = false;
      initManueljeu = false;
      mode = 2;
      afficheCouleurs();
      Palette2();
    }
    if (key == '3') {
      initmode3 = true;
      initManueljeu = false;
      mode = 3;
      creaManuel();
    }
    if (key == '+' && mode == 3){
        finiManuel();
      }
      if(key == '-'  && mode == 3){
        initManueljeu = true;
        Manueljeu();
      }
    if (key == '4') {
      initmode3 = false;
      initManueljeu = false;
      mode = 4;
      afficheImportation();
    }
  }
  textSize(50);
  if (key == CODED) {
    if (keyCode==SHIFT && (mode == 1 || mode == 2)) {
      if (verification() == true) {
        fill(145, 141, 162);
        rect(50+nbcol*tailleC+50, tailleMenu+10, tailleC*4, tailleC*2-20);
        fill(0, 255, 0);
        text("Gagné !", nbcol*tailleC+100, tailleMenu+75);
      } else {
        fill(145, 141, 162);
        rect(50+nbcol*tailleC+50, tailleMenu+10, tailleC*4, tailleC*2-20);
        fill(255, 0, 0);
        text("Perdu !", nbcol*tailleC+100, tailleMenu+75);
      }
    }
  }
  textSize(20);
  fill(237, 237, 237);
}


void mousePressed() {
  cliquee = true;
  if (mode == 1) {
    int jouableXmin = 50;
    int jouableXmax = jouableXmin+nbcoljouable*tailleC;
    int jouableYmin = 100+(maxCol)*tailleC;
    int jouableYmax = jouableYmin+nbligjouable*tailleC;
    if (mousePressed && mouseX >= jouableXmin && mouseX <= jouableXmax && mouseY >= jouableYmin && mouseY <= jouableYmax) {
      int clicY = mouseX/tailleC;
      int clicX = mouseY/tailleC;
      if (nb_couleurs == 2) {
        if (g.tab[clicX-2][clicY-1].couleur == 0) {
          g.tab[clicX-2][clicY-1].couleur = 1;
        } else {
          g.tab[clicX-2][clicY-1].couleur = 0;
        }
      } else {
        g.tab[clicX-2][clicY-1].couleur = couleurAct;
      }
    }
    if ((mousePressed && mouseX >= ((width/4)*3)-10) && (mousePressed && mouseX <= width-10)) {
      if ((mousePressed && mouseY >=380) && (mousePressed && mouseY <= 410)) {
        fichierAct = f[3];
        change = true;
      } else if ((mousePressed && mouseY >=413) && (mousePressed && mouseY <= 435)) {
        fichierAct = f[4];
        change = true;
      } else if ((mousePressed && mouseY >=438) && (mousePressed && mouseY <= 460)) {
        fichierAct = f[5];
        change = true;
      }
    }
  }
  if (mode == 2) {
    int jouableXmin = 50;
    int jouableXmax = jouableXmin+nbcoljouable*tailleC;
    int jouableYmin = 100+(maxCol)*tailleC;
    int jouableYmax = jouableYmin+nbligjouable*tailleC;
    if (mousePressed && mouseX >= jouableXmin && mouseX <= jouableXmax && mouseY >= jouableYmin && mouseY <= jouableYmax) {
      int clicY = mouseX/tailleC;
      int clicX = mouseY/tailleC;
      if (nb_couleurs == 2) {
        if (g.tab[clicX-2][clicY-1].couleur == 0) {
          g.tab[clicX-2][clicY-1].couleur = 1;
        } else {
          g.tab[clicX-2][clicY-1].couleur = 0;
        }
      } else {
        g.tab[clicX-2][clicY-1].couleur = couleurAct;
      }
    }
    if ((mousePressed && mouseX >= ((width/4)*3)-10) && (mousePressed && mouseX <= width-10)) {
      if ((mousePressed && mouseY >=380) && (mousePressed && mouseY <= 410)) {
        fichierAct = f[0];
        change = true;
      } else if ((mousePressed && mouseY >=413) && (mousePressed && mouseY <= 435)) {
        fichierAct = f[1];
        change = true;
      } else if ((mousePressed && mouseY >=438) && (mousePressed && mouseY <= 460)) {
        fichierAct = f[2];
        change = true;
      }
    }
  }
  if (mode == 3) {
    int jouableXmin = 50;
    int jouableXmax = jouableXmin+nbcol*tailleC;
    int jouableYmin = 100;
    int jouableYmax = jouableYmin+nblig*tailleC;
    if (mousePressed && mouseX >= jouableXmin && mouseX <= jouableXmax && mouseY >= jouableYmin && mouseY <= jouableYmax) {
      print(1);
      int clicY = mouseX/tailleC;
      int clicX = mouseY/tailleC;
      g.tab[clicX-2][clicY-1].couleur = couleurAct;
    }
  }
}


void afficheClassique() {
  fichierAct = f[3];
  afficheMenu();
  textSize(20);
  text("Couleurs", 375, 45);
  textSize(28);
  text("Classique", 100, 45);
  textSize(20);
  text("Manuel", 650, 45);
  text("Importation du jeu", width-300, 45);
  textSize(22);
  text("Classique : touche 1 ", (width/4)*3, 215);
  text("Couleurs : touche 2", (width/4)*3, 255);
  text("Manuel : touche 3", (width/4)*3, 295);
  text("Importation : touche 4", (width/4)*3, 335);
  // parties cliquables
  textSize(18);
  text("NB - Ancre ", (width/4)*3, 410);
  text("NB - Avion", (width/4)*3, 435);
  text("NB - Chameau", (width/4)*3, 460);
  text("Touche SHIFT pour vérifier la grille", (width/4)*3, 510);
  // partie jeu utilisateur à gauche
  g = new Grille();
  chargerFichier(fichierAct);
  tailleGrilletotale();
  g.initG();
  g.remplissage_grille();
  g.dessin(fichierAct);
}

void afficheCouleurs() {
  fichierAct = f[0];
  afficheMenu();
  textSize(28);
  text("Couleurs", 375, 45);
  textSize(20);
  text("Classique", 100, 45);
  text("Manuel", 650, 45);
  text("Importation du jeu", width-300, 45);
  textSize(18);
  text("Couleurs - Chien ", (width/4)*3, 410);
  text("Couleurs - Oiseau", (width/4)*3, 435);
  text("Couleurs - Parapluie", (width/4)*3, 460);
  text("Touche SHIFT pour vérifier la grille", (width/4)*3, 510);
  // partie jeu utilisateur à gauche
  g = new Grille();
  chargerFichier(fichierAct);
  tailleGrilletotale();
  largeurGrille=nbcol*tailleC;
  g.initG();
  g.remplissage_grille();
  g.dessin(fichierAct);
}

void afficheImportation() {
  afficheMenu();
  background(145, 141, 162);
  noStroke();
  fill(47, 9, 109);
  rect(0, 0, width, 75);
  stroke(255);
  strokeWeight(4);
  fill(255, 255, 255, 50);
  line((width/4)*3-25, 175, width-25, 175);
  rect((width/4)*3-25, 100, 300, height/2);
  strokeWeight(1);
  noStroke();
  fill(255);
  textSize(20);
  text("Classique", 100, 45);
  text("Couleurs", 375, 45);
  text("Manuel", 650, 45);
  textSize(28);
  text("Importation du jeu", width-300, 45);
  // partie menu à droite
  textSize(36);
  text("MENU", (width/4)*3+75, 150);
  textSize(22);
  text("Classique : touche 1 ", (width/4)*3, 215);
  text("Couleurs : touche 2", (width/4)*3, 255);
  text("Manuel : touche 3", (width/4)*3, 295);
  text("Importation : touche 4", (width/4)*3, 335);
  textSize(45);
  fill(0,0,0,100);
  text("Mode en cours de construction", width/5+2, height/2+2);
  fill(255, 0, 0);
  text("Mode en cours de construction", width/5, height/2);
}

void afficheMenu(){
  background(145, 141, 162);
  noStroke();
  fill(47, 9, 109);
  rect(0, 0, width, 75);
  stroke(255);
  strokeWeight(4);
  fill(255, 255, 255, 50);
  line((width/4)*3-25, 175, width-25, 175);
  rect((width/4)*3-25, 100, 300, height/2);
  strokeWeight(1);
  noStroke();
  fill(255);
  // partie menu à droite
  textSize(36);
  text("MENU", (width/4)*3+75, 150);
  textSize(22);
  text("Classique : touche 1 ", (width/4)*3, 215);
  text("Couleurs : touche 2", (width/4)*3, 255);
  text("Manuel : touche 3", (width/4)*3, 295);
  text("Importation : touche 4", (width/4)*3, 335);

}

color[] chargerFichier(String nomfichier) {
  String []fichier = loadStrings(nomfichier);
  String []taille = splitTokens(fichier[0], " ");
  nbligjouable = int(taille[1]);
  nbcoljouable = int(taille[0]);
  figure = new int[nbligjouable][nbcoljouable];
  for (int i=0; i<nbligjouable; i++) {
    String []lignei = splitTokens(fichier[i+1], " ");
    for (int j=0; j<nbcoljouable; j++) {

      figure[i][j] = int(lignei[j]);
    }
  }

  nb_couleurs = int(fichier[nbligjouable+1]);
  color[] tab_couleurs = new color[nb_couleurs];
  int ind=0;
  for (int j = nbligjouable+2; j<fichier.length; j++) {
    String []c = splitTokens(fichier[j]);
    int r = int(c[1]);
    int g = int(c[2]);
    int b = int(c[3]);
    color couleur_case = color(r, g, b);
    tab_couleurs[ind] = couleur_case;
    ind++;
  }
  return tab_couleurs;
}

int[][] grilleFichier(){
  int tabi[][] = new int [nbligjouable][nbcoljouable];
  int cpt = 0;
  for (int i = nblig-nbligjouable; i<nblig; i++) {
    for (int j = 0; j<nbcoljouable; j++) {
      tabi[cpt][j] = g.tab[i][j].couleur;
    }
    cpt++;
  }
  return tabi;
}

boolean verification() {
  int tabjoueur[][] = grilleFichier();
  //test des indices des lignes
  for (int i = 0; i<nbligjouable; i++) {
    int idligijoueur[][] = chercheLigne(i, tabjoueur);
    int idligifigure[][] = chercheLigne(i, figure);
    if (idligijoueur[0].length != idligifigure[0].length) {
      return false;
    }
    for (int j = 0; j<idligijoueur[0].length; j++) {
      if (idligijoueur[0][j] != idligifigure[0][j] || idligijoueur[1][j] != idligifigure[1][j]) {
        return false;
      }
    }
  }
  //test des indices des colonnes
  int i = 0;
  while (i<nbcoljouable) { //<>//
    int idcolijoueur[][] = chercheColonne(i, tabjoueur);
    int idcolifigure[][] = chercheColonne(i, figure);
    if (idcolijoueur[0].length != idcolifigure[0].length) {
      return false;
    }
    for (int j = 0; j<idcolijoueur[0].length; j++) {
      if (idcolijoueur[0][j] != idcolifigure[0][j] || idcolijoueur[1][j] != idcolifigure[1][j]) {
        return false;
      }
    }
    i++;
  }
  return true;
}

int [][] chercheLigne(int x, int tableau[][]) { //parcours la ligne x et renvoie un tableau des indices de la ligne si pas d'indice renvoie tab vide
  int tab[][] = new int [2][nbcoljouable]; // [0] indices, [1] couleurs
  int cpt = 0;
  for (int i = 0; i<nbcoljouable-1; i++) {
    if (tableau[x][i] != 0) {
      tab[0][cpt]+=1;
      tab[1][cpt]=tableau[x][i];
    }
    if (tableau[x][i] != 0 && tableau[x][i] != tableau[x][i+1]) {
      cpt +=1;
    }
  }
  if (tableau[x][nbcoljouable-1] != 0) {
    if (tableau[x][nbcoljouable-1] != tableau[x][nbcoljouable-2] && tableau[x][nbcoljouable-2] == 0) {
      tab[0][cpt] += 1;
      tab[1][cpt]=tableau[x][nbcoljouable-1];
    } else if (tableau[x][nbcoljouable-1] == tableau[x][nbcoljouable-2]) {
      tab[0][cpt] += 1;
    } else if (tableau[x][nbcoljouable-1] != tableau[x][nbcoljouable-2] && tableau[x][nbcoljouable-2] != 0) {
      tab[0][cpt] += 1;
      tab[1][cpt]=tableau[x][nbcoljouable-1];
    }
  } else {
    cpt-=1;
  }
  int res[][] = new int [2][cpt+1];
  for (int i = 0; i<cpt+1; i++) {
    res[0][i] = tab[0][i];
    res[1][i] = tab[1][i];
  }
  return res;
}

int [][] chercheColonne(int x, int tableau[][]) { //parcours la colonne y et renvoie un tableau des indices de la colonne
  int tab[][] = new int [2][nbligjouable]; // [0] indices, [1] couleurs
  int cpt = 0;
  for (int i = 0; i<nbligjouable-1; i++) {
    if (tableau[i][x] != 0) {
      tab[0][cpt]+=1;
      tab[1][cpt]=tableau[i][x];
    }
    if (tableau[i][x] != 0 && tableau[i][x] != tableau[i+1][x]) {
      cpt +=1;
    }
  }
  if (tableau[nbligjouable-1][x] != 0) {
    if (tableau[nbligjouable-1][x] != tableau[nbligjouable-2][x] && tableau[nbligjouable-2][x] == 0) {
      tab[0][cpt] += 1;
      tab[1][cpt]=tableau[nbligjouable-1][x];
    } else if (tableau[nbligjouable-1][x] == tableau[nbligjouable-2][x]) {
      tab[0][cpt] += 1;
    } else if (tableau[nbligjouable-1][x] != tableau[nbligjouable-2][x] && tableau[nbligjouable-2][x] != 0) {
      tab[0][cpt] += 1;
      tab[1][cpt]=tableau[nbligjouable-1][x];
    }
  } else {
    cpt-=1;
  }
  int res[][] = new int [2][cpt+1];
  for (int i = 0; i<cpt+1; i++) {
    res[0][i] = tab[0][i];
    res[1][i] = tab[1][i];
  }
  return res;
}

void tailleGrilletotale() {
  for (int i = 0; i<nbligjouable; i++) {
    if (chercheLigne(i, figure)[0].length > maxLig) {
      maxLig = chercheLigne(i, figure)[0].length;
    }
  }
  for (int i = 0; i<nbcoljouable; i++) {
    if (chercheColonne(i, figure)[0].length > maxCol) {
      maxCol = chercheColonne(i, figure)[0].length;
    }
  }
  nblig = maxCol + nbligjouable;
  nbcol = maxLig + nbcoljouable;
}

void Palette2() {
  //interaction palette P2
  chargerFichier(fichierAct);
  tabCouleurP3 =  new int[nb_couleurs];
  if (nb_couleurs%2==0) {
    int j=0;
    for (int i=0; i<nb_couleurs/2; i++) {
      fill(chargerFichier(fichierAct)[j]);
      tabCouleurP3[j]=j;
      rect(50+nbcol*tailleC+50, 100+tailleMenu+(i*tailleC), tailleC, tailleC);
      fill(chargerFichier(fichierAct)[j+1]);
      tabCouleurP3[j+1]=j+1;
      rect(50+nbcol*tailleC+50+tailleC, 100+tailleMenu+(i*tailleC), tailleC, tailleC);
      j=j+2;
    }
  } else {
    int k=0;
    for (int i=0; i<nb_couleurs/2; i++) {
      fill(chargerFichier(fichierAct)[k]);
      tabCouleurP3[k]=chargerFichier(fichierAct)[k];
      rect(50+nbcol*tailleC+50, 100+tailleMenu+(i*tailleC), tailleC, tailleC);
      fill(chargerFichier(fichierAct)[k+1]);
      tabCouleurP3[k+1]=chargerFichier(fichierAct)[k+1];
      rect(50+nbcol*tailleC+50+tailleC, 100+tailleMenu+(i*tailleC), tailleC, tailleC);
      k=k+2;
    }
    fill(chargerFichier(fichierAct)[nb_couleurs-1]);
    tabCouleurP3[nb_couleurs-1]=chargerFichier(fichierAct)[nb_couleurs-1];
  }

  int paletteXmin = 50 + nbcol*tailleC+50;
  int paletteXmax = paletteXmin + (tailleC * 2);
  int paletteYmin = 100 + tailleMenu;
  int paletteYmax = paletteYmin + (tailleC * nb_couleurs / 2);

  if (nb_couleurs % 2 == 0) {
    int j = 0;

    if (mousePressed && mouseX >= paletteXmin && mouseX <= paletteXmax && mouseY >= paletteYmin && mouseY <= paletteYmax) {
      for (int i = 0; i < nb_couleurs / 2; i++) {
        if (mouseX >= 50 + nbcol*tailleC+50 && mouseX <= 50 + nbcol*tailleC+50 + tailleC && mouseY >= 100 + tailleMenu + (i * tailleC) && mouseY <= (100 + tailleMenu + (i * tailleC)) + tailleC) {
          couleurAct = j;
        }
        if (mouseX >= 50 + nbcol*tailleC+50 + tailleC && mouseX <= 150 + nbcol*tailleC+50 + (2 * tailleC) && mouseY >= 100 + tailleMenu + (i * tailleC) && mouseY <= (100 + tailleMenu + (i * tailleC)) + tailleC) {
          couleurAct = j+1;
        }
        j = j + 2;
      }
    }
  } else {
    int k = 0;
    for (int i = 0; i < (nb_couleurs / 2) + 1; i++) {
      fill(tabCouleurP3[k]);
      rect(50 + nbcol*tailleC+50, 100 + tailleMenu + (i * tailleC), tailleC, tailleC);

      // Vérifier si la souris est sur la couleur
      if (mousePressed && mouseX >= 50 + nbcol*tailleC+50 && mouseX <= 50 + nbcol*tailleC+50 + tailleC && mouseY >= 100 + tailleMenu + (i * tailleC) && mouseY <= (100 + tailleMenu + (i * tailleC)) + tailleC) {
        couleurAct = k;
      }

      if (i < nb_couleurs / 2) {

        // Vérifier si la souris est sur la couleur
        if (mousePressed && mouseX >= 50 + nbcol*tailleC+50 + tailleC && mouseX <= 50 + nbcol*tailleC+50 + (2 * tailleC) && mouseY >= 100 + tailleMenu + (i * tailleC) && mouseY <= (100 + tailleMenu + (i * tailleC)) + tailleC) {
          couleurAct = k+1;
        }
      }
      k = k + 2;
    }
  }
}
