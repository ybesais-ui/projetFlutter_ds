plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    id("dev.flutter.flutter-gradle-plugin") // plugin Flutter
    id("com.google.gms.google-services") // firebase
}


android {
    // Namespace du module Android (pas obligatoire que = applicationId, mais doit être valide)
    namespace = "com.example.projetflutter_ds"

    // Version du SDK Android utilisée pour compiler (récupérée via Flutter)
    compileSdk = flutter.compileSdkVersion

    // Version du NDK utilisée (Native Development Kit)
    ndkVersion = flutter.ndkVersion

    compileOptions {
        // Version Java supportée par l’application
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        // Version de la JVM cible pour Kotlin
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // Identifiant unique de l’application Android
        applicationId = "com.example.projetflutter_ds"

        // Version minimale du SDK Android (Firebase exige au minimum 23)
        minSdk = flutter.minSdkVersion // On force 23 pour éviter les erreurs Firebase

        // SDK Android ciblé par l’application
        targetSdk = flutter.targetSdkVersion

        // Version interne (utilisée par Android pour mise à jour)
        versionCode = flutter.versionCode

        // Version affichée à l’utilisateur
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // Configuration de signature pour build release (ici debug temporairement)
            signingConfig = signingConfigs.getByName("debug")
            // À remplacer par une vraie clé pour la publication plus tard
        }
    }
}

// Dépendances Firebase, ajoutées après la configuration Android
dependencies {
    // Firebase BoM (Bill of Materials) pour gérer automatiquement les versions compatibles
    implementation(platform("com.google.firebase:firebase-bom:34.6.0"))

    // SDK Firebase Analytics pour tracker les événements
    implementation("com.google.firebase:firebase-analytics")

    // SDK Firestore pour base de données NoSQL
    implementation("com.google.firebase:firebase-firestore")

    // SDK Firebase Auth pour authentification utilisateurs
    implementation("com.google.firebase:firebase-auth")
}

flutter {
    // Chemin source vers le projet Flutter
    source = "../.."
}
