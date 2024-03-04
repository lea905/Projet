class Case {
  int couleur;
  int lig, col;
  boolean etat; // true:indice
  String texte;

  void init(int c, int l, int coln, boolean e, String t) {
    this.couleur = c;
    this.lig = l;
    this.col = coln;
    this.etat = e;
    this.texte = t;
  }

  void dessin(String nomfichier) {
    if (couleur == -1) fill(255, 0, 0); // couleur des cases qui ne sont ni jouables ni des indices
    else {
      fill(chargerFichier(nomfichier)[this.couleur]);
      rect(this.col*tailleC+50, this.lig*tailleC+100, tailleC, tailleC);
      fill(255);
      textSize(tailleC/4);
      text(this.texte, this.col*tailleC+tailleC/2+50, this.lig*tailleC+tailleC/2+100);
    }
  }
  
  void dessinManuel(){
    fill(tabCouleurP4[this.couleur]);
    rect(this.col*tailleC+50, this.lig*tailleC+100, tailleC, tailleC);
  }
}
