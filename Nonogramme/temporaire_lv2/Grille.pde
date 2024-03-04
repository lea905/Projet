class Grille { //<>//
  Case tab[][];

  void initG() {
    tab = new Case [nblig][nbcol];
    for (int i = 0; i<tab.length; i++) {
      for (int j = 0; j<tab[0].length; j++) {
        tab[i][j] = new Case();
      }
    }
  }

  void remplissage_grille() { // grille de base sans rien
    for (int i = 0; i<tab.length; i++) {
      for (int j = 0; j<tab[0].length; j++) {
        tab[i][j] = new Case();
        tab[i][j].init(0, i, j, false, "");
      }
    }


    int cpt1 = 1; // marche
    for (int i = maxCol-1; i>=0; i--) { //num de la ligne a remplir
      for (int j = 0; j<nbcoljouable; j++) { //parcours les cases de la ligne i
        if (chercheColonne(j, figure)[0].length >= cpt1) {
          tab[i][j].init(chercheColonne(j, figure)[1][chercheColonne(j, figure)[0].length-cpt1], i, j, true, str(chercheColonne(j, figure)[0][chercheColonne(j, figure)[0].length-cpt1]));
        }
      }
      cpt1 += 1;
    }

    int cptL = 0;
    for (int i = maxCol; i<nblig; i++) {
      int cptCaseTableau=0;
      println(chercheLigne(cptL, figure).length);
      for (int j = nbcoljouable; j<chercheLigne(cptL, figure)[0].length+nbcoljouable; j++) {
        tab[i][j].init(chercheLigne(cptL, figure)[1][cptCaseTableau], i, j, true, str(chercheLigne(cptL, figure)[0][cptCaseTableau]));
        cptCaseTableau++;
      }
      cptL++;
    }
  }

  void dessin(String nomfichier) {
    for (int i = 0; i <tab.length; i++) {
      for (int j = 0; j<tab[0].length; j++) {
        if (tab[i][j].etat == false && (i<nblig-nbligjouable || j>=nbcoljouable)) {
          noStroke();
          tab[i][j].couleur = -1;
          tab[i][j].dessin(nomfichier);
        } else if (tab[i][j].etat == true) {
          stroke(255);
          tab[i][j].dessin(nomfichier);
        } else {
          stroke(0);
          tab[i][j].dessin(nomfichier);
        }
      }
    }
  }
  
  void remplissageManuel(){
    for (int i = 0; i<tab.length; i++) {
      for (int j = 0; j<tab[0].length; j++) {
        tab[i][j] = new Case();
        tab[i][j].init(0, i, j, false, "");
      }
    }
  }
  
  void dessinManuelg(){
    stroke(0);
    for (int i = 0; i <tab.length; i++) {
      for (int j = 0; j<tab[0].length; j++) {
        tab[i][j].dessinManuel();
      }
    }
  }
  /*
  void dessinManueljeu(){
    for (int i = 0; i <tab.length; i++) {
      for (int j = 0; j<tab[0].length; j++) {
        if (tab[i][j].etat == false && (i<nblig-nbligjouable || j>=nbcoljouable)) {
          noStroke();
          tab[i][j].couleur = -1;
          tab[i][j].dessinManuel();
        } else if (tab[i][j].etat == true) {
          stroke(255);
          tab[i][j].dessinManuel();
        } else {
          stroke(0);
          tab[i][j].dessinManuel();
        }
      }
    }
  }*/
}
