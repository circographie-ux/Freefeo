# Diffusion CRM — version connectée

Application full-stack préparée pour un déploiement réel.

## Inclus
- PostgreSQL + PostGIS
- authentification utilisateurs
- plusieurs boîtes mail en base
- annuaire et contacts multiples
- import XLS/XLSX
- recherche géographique PostGIS
- Google Maps intégré côté interface
- listes de diffusion
- historique des e-mails avec texte intégral
- statistiques de programmation par discipline dans le schéma
- stockage des pièces jointes à préparer/brancher sur un stockage objet

## Démarrage local
1. Copier `.env.example` vers `.env`.
2. `docker compose up -d db`
3. `docker compose exec db psql -U diffusion -d diffusion -f /app/db/schema.sql` (ou exécuter `db/schema.sql` avec psql).
4. `npm install`
5. `npm start`
6. Ouvrir `http://localhost:3000`

## Mise en ligne
Le projet est prêt pour Render/Railway. Il faut toutefois connecter le compte de l'hébergeur et renseigner les secrets (JWT, Google Maps, OAuth Gmail/Microsoft).

## Important
L'envoi Gmail/Outlook réel nécessite OAuth et les identifiants développeur des fournisseurs. Le code sépare déjà les boîtes mail afin de permettre plusieurs comptes.


## Premier accès / administrateur

Le premier compte est automatiquement créé au démarrage si la table `users` est vide. Configurez `BOOTSTRAP_ADMIN_NAME`, `BOOTSTRAP_ADMIN_EMAIL` et `BOOTSTRAP_ADMIN_PASSWORD` dans les variables d’environnement. Le compte initial est créé avec le rôle `admin`, puis l’inscription publique est désactivée. Les utilisateurs suivants doivent être créés par un administrateur via `POST /api/users`.

Pour le compte Circographie, utilisez `BOOTSTRAP_ADMIN_EMAIL=circographie@gmail.com` et définissez le mot de passe choisi dans `BOOTSTRAP_ADMIN_PASSWORD` (ne mettez pas le mot de passe dans Git).
