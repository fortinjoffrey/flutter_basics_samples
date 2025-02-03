Hypothèse 1

App hote qui utilise deux packages

- Un package flutter
-           user connection
-                 --> widget avec bouton de connexion
-                 --> connexion webview + stockage de tokens
- Un package dart
-           user manager
-                 --> injecter userId + tokenProvider
-                 --> call API pour récupérer des informations sur l'utilisateur (list des ID vehicule)
- Un package flutter
-           garage_view (montrer mes véhicules)
-                 -> tokenProvider
-                 --> call API pour récupérer les véhicules du user
-

App hote flow

-> Me connecter (via user connection)
-> Récupérer les informations du User
-> Montrer mes véhicules

1. 1er widget: user connection
2. Si connexion succès alors je récupère mes tokens dans le secure storage
3. Je fais userInformation.getUser(TokensProvider)
4. 2eme widget: garage_view dans lequel j'injecte tokenProvider + user vehicles ID
