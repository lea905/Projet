void initManuel(){
  nbcol=Clavier.lireEntier("Largeur que vous souhaitez");
  while(nbcol>=8 || nbcol<=0){
    nbcol=Clavier.lireEntier("Largeur que vous souhaitez (entre 0 et 7)");
  }
  nblig=Clavier.lireEntier("Hauteur que vous souhaitez");
  while(nblig>=8 || nblig<=0){
    nblig=Clavier.lireEntier("Hauteur que vous souhaitez (entre 0 et 7)");
  }
  largeurGrille = nbcol*tailleC;
  maxCol=nbcol;
  maxLig=nblig;
  nbligjouable = nblig;
  nbcoljouable = nbcol;
  nb_couleurs = 6;
  tabCouleurP4[0]= color(255);
  tabCouleurP4[1]= color(0);
  tabCouleurP4[2]= color(255, 0, 0);
  tabCouleurP4[3]= color(90, 198, 114);
  tabCouleurP4[4]= color(0, 0, 255);
  tabCouleurP4[5]= color(255, 165, 0);
  g = new Grille();
  g.initG();
  g.remplissageManuel();
  initmode3 = false;
}

void creaManuel(){
  afficheMenu();
  textSize(20);
  text("Couleurs", 375, 45);
  text("Classique", 100, 45);
  textSize(28);
  text("Manuel", 650, 45);
  textSize(20);
  text("Importation du jeu", width-300, 45);
  // partie menu à droite
  textSize(36);
  text("MENU", (width/4)*3+75, 150);
  textSize(22);
  text("Classique : touche 1 ", (width/4)*3, 215);
  text("Couleurs : touche 2", (width/4)*3, 255);
  text("Manuel : touche 3", (width/4)*3, 295);
  text("Importation : touche 4", (width/4)*3, 335);
  text("Enregistrer : touche +", (width/4)*3, 470);
  text("Jouer création : touche -", (width/4)*3, 510);
  if(initmode3 == true) initManuel();
  Palette4();
  g.dessinManuelg();
}

void finiManuel(){
  nomFichierU=Clavier.lireString("Le titre de votre création");
  int tabjoueur[][] = grilleFichier();
  
  PrintWriter output = createWriter(nomFichierU+".txt");
  //ligne 1
  output.print(nbcol);
  output.print(' ');
  output.println(nblig);

  //ligne de la grille
  for (int k=0; k<tabjoueur.length; k++) {
    for (int j=0; j<tabjoueur[0].length; j++) {
      output.print(tabjoueur[k][j]);
      output.print(' ');
    }
    output.println();
  }

  //ligne du nombre de couleur total
  output.println(nb_colors);

  //lignes des couleurs du fichier
  output.print(0);
  output.println(" 255 255 255");
  output.print(1);
  output.println(" 0 0 0");
  output.print(2);
  output.println(" 255 0 0");
  output.print(3);
  output.println(" 90 198 114");
  output.print(4);
  output.println(" 0 0 255");
  output.print(5);
  output.println(" 255 165 0");
  output.flush();
}

void Manueljeu() {
  afficheMenu();
  textSize(20);
  text("Couleurs", 375, 45);
  text("Classique", 100, 45);
  textSize(28);
  text("Manuel", 650, 45);
  textSize(20);
  text("Importation du jeu", width-300, 45);
  // partie menu à droite
  textSize(36);
  text("MENU", (width/4)*3+75, 150);
  textSize(22);
  text("Classique : touche 1 ", (width/4)*3, 215);
  text("Couleurs : touche 2", (width/4)*3, 255);
  text("Manuel : touche 3", (width/4)*3, 295);
  text("Importation : touche 4", (width/4)*3, 335);
  text("Enregistrer : touche +", (width/4)*3, 470);
  text("Jouer création : touche -", (width/4)*3, 510);
  if(initManueljeu == true) initManueljeu();
}

void initManueljeu(){
  fichierAct=Clavier.lireString("Nom du fichier à importer (sans le .txt)")+".txt";
  g = new Grille();
  chargerFichier(fichierAct);
  tailleGrilletotale();
  largeurGrille=nbcol*tailleC;
  g.initG();
  g.remplissage_grille();
  g.dessin(fichierAct);
  initManueljeu = false;
}

void Palette4() {
  noStroke();
  int xminP4 = 50+largeurGrille+50;
  int xmaxP4 = xminP4 + (tailleC * 2);
  int yminP4 = 100+tailleMenu;
  int ymaxP4 = yminP4 + (tailleC * nb_couleurs / 2);
  
  int j = 0;
  if (mousePressed && mouseX >= xminP4 && mouseX <= xmaxP4 && mouseY >= yminP4 && mouseY <= ymaxP4) {
    for (int i = 0; i < nb_couleurs / 2; i++) {
      if (mouseX >= xminP4 && mouseX <= xminP4 + tailleC && mouseY >= yminP4 + (i * tailleC) && mouseY <= (yminP4 + (i * tailleC)) + tailleC) {
        couleurAct = j;
      }
      if (mouseX >= xminP4 + tailleC && mouseX <= xmaxP4 +100 && mouseY >= yminP4 + (i * tailleC) && mouseY <= (yminP4 + (i * tailleC)) + tailleC) {
        couleurAct = j+1;
      }
      j = j + 2;
    }
  }

  int m = 0;
  //noir
  fill(tabCouleurP4[0]);
  rect(xminP4, yminP4+(m*tailleC), tailleC, tailleC);

  //blanc
  fill(tabCouleurP4[1]);
  rect(xminP4+tailleC, yminP4+(m*tailleC), tailleC, tailleC);
  m++;

  //rouge
  fill(tabCouleurP4[2]);
  rect(xminP4, yminP4+(m*tailleC), tailleC, tailleC);

  //vert
  fill(tabCouleurP4[3]);
  rect(xminP4+tailleC, yminP4+(m*tailleC), tailleC, tailleC);
  m++;

  //bleu
  fill(tabCouleurP4[4]);
  rect(xminP4, yminP4+(m*tailleC), tailleC, tailleC);

  //orange
  fill(tabCouleurP4[5]);
  rect(xminP4+tailleC, yminP4+(m*tailleC), tailleC, tailleC);
  m++;
}

color intToColor(int valeur) {//valeur comprise entre 0 et 999
  int r=valeur/(256*256);
  int g=(valeur%(256*256))/256;
  int b=(valeur%(256*256))%256;
  return color(r, g, b);
}
