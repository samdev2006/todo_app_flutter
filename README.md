# TodoApp

Application mobile de gestion de tâches personnelles, développée avec Flutter et Firebase dans le cadre d’un test technique.

## Stack technique

- **Flutter** (mobile Android)
- **Firebase Authentication** (email / mot de passe)
- **Cloud Firestore** (base de données temps réel)
- **flutter_bloc** (gestion d’état)
- **equatable** (comparaison d’objets)

## Architecture : Clean Architecture en 3 couches

```
lib/
├── features/
│   ├── auth/
│   │   ├── domain/        # Entités, interfaces, use cases
│   │   ├── data/          # DataSources Firebase, modèles, repositories
│   │   └── presentation/  # Bloc, pages Login/Register
│   └── tasks/
│       ├── domain/        # Entités, interfaces, use cases
│       ├── data/          # DataSources Firestore, modèles, repositories
│       └── presentation/  # Bloc, pages Liste/Formulaire
└── main.dart
```

### Domain

Cœur de l’application, indépendant de Firebase et de Flutter. Contient les entités (`UserEntity`, `TaskEntity`), les interfaces de repository (`AuthRepository`, `TaskRepository`) et les use cases (`SignInUseCase`, `AddTaskUseCase`, etc.).

### Data

Implémentations concrètes des repositories, data sources Firebase/Firestore, et modèles avec mapping (`fromFirestore`, `toMap`). C’est la seule couche qui connaît Firebase.

### Présentation

UI Flutter et gestion d’état avec Bloc. Appelle uniquement les use cases, jamais Firebase directement.

## Fonctionnalités

- Inscription et connexion par email / mot de passe
- Création, lecture, modification, suppression de tâches (CRUD complet)
- Affichage temps réel via Stream Firestore
- Isolation des données : chaque utilisateur ne voit que ses propres tâches
- Validation du formulaire : titre vide → message d’erreur
- État de chargement visible pendant les requêtes
- Message “Aucune tâche” si la liste est vide
- Gestion des erreurs Firebase affichée à l’utilisateur

## Lancer le projet

### Prérequis

- Flutter SDK installé
- Un émulateur Android ou un appareil physique connecté
- Un projet Firebase configuré (Authentication + Firestore activés)

### Étapes

1. Clone le dépôt :
   
   ```bash
   git clone https://github.com/samdev2006/todo_app_flutter
   cd todoapp
   ```
1. Installe les dépendances :
   
   ```bash
   flutter pub get
   ```
1. Configure Firebase :
   
   ```bash
   flutterfire configure
   ```
   
   Sélectionne ton projet Firebase — cela génère `lib/firebase_options.dart`.
1. Lance l’application :
   
   ```bash
   flutter run
   ```

## Sécurité Firestore

Les règles de sécurité vérifient côté serveur que chaque utilisateur ne peut lire et modifier que ses propres tâches (`request.auth.uid == resource.data.userId`), en complément du filtre côté client.

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /tasks/{taskId} {
      allow read, write: if request.auth != null 
        && request.auth.uid == resource.data.userId;
      allow create: if request.auth != null 
        && request.auth.uid == request.resource.data.userId;
    }
  }
}
```