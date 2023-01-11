# PROBLEMES A REGLER !

- quand on crée un user a partir de la page d'inscription (Registration), l'id du nouvel user n'est pas l'id suivant mais celui d'encore après (EX : il y a 3 users, on en ajoute un nouveau a partir de cette page. Il aura alors l'id 5 au lieu d'avoir l'id 4)

- probleme de tokens quand on on veut acceder au comics alors qu'ils sont en AUTHENTIFICATED_FULLY dans security.yaml