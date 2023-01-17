# PROBLEMES A REGLER !

- probleme de tokens quand on on veut acceder au comics alors qu'ils sont en AUTHENTIFICATED_FULLY dans security.yaml (a verifier si le probleme est toujours la car l'API a étét refaite)
- PageItem en fonction du nom du comics ou de l'id ( path: '/PageItem/:id' ) qui est biaisé a cause du localStorage

# TRUCS A FAIRE

- navbar qui disparait en scroll-down et reaparait en scroll-top (mieux pour la lecture) (voir https://www.w3schools.com/howto/howto_js_navbar_hide_scroll.asp)
- infinite scroll (pour eviter de charger toutes les images du comics d'un coup)
- styliser le site (pages connexion/inscription, PageItem, etc...)
- gerer systeme de paiement (PayPal, carte bancaire, Pitou Coin, etc...)
- changer d'hebergeur d'images (VPS, Digital Ocean, etc...)
- faire la version mobile (CSS : media queries)
- footer
- page informations utilisateurs
- page de gestion des comics (ajout, suppression, modification)
- page ADMIN : gestion des utilisateurs (ajout, suppression, modification), gestion des comics (ajout, suppression, modification)
- page de gestion des paiements (ajout, suppression, modification)
- commentaires
- notes du comics


# A GARDER EN TETE

- normalement pas besoin d'implementer les guard quand les tokens expirent car jai fixé leur durée de vie à 10h ( averifier)