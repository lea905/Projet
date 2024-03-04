/*Cible leadModal et l'enregistre avec une variable*/
var modal = document.getElementById("leadModal");
console.log(modal,'consol log de modal');

var btn = document.getElementById("bntNo");

document.getElementById("btnMailto").innerHTML = "Contactez-moi";
//Modification du texte si cliqué
console.log("la fonction est bien appelée");
btnMailto.onclick = function () {
    document.getElementById("btnMailto").innerHTML = "A très bientôt";
    console.log("après avoir ciblé élément");
}
alert("Bienvenu sur le site");

window.onscroll=function() {

}

function modalHomePage(){
    if(document.body.scrollTop > 1 || document.documentElement.scrollTop> 1){
        modal.style.display = 'block';
        //annule l'evenement window.onscroll
        window.onscroll = null;
    }
}

window.onscroll = function(){ modalHomePage()};

btn.onclick= function(){
    modal.style.display = "none" ;
}

