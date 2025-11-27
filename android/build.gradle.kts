// ⚠️ Supprimer toute déclaration de com.android.application avec version !
// Le plugin Android est déjà inclus par Flutter, donc on ne doit pas le redéfinir ici.

plugins {
    // Plugin Kotlin Android pour la compatibilité Android
    id("org.jetbrains.kotlin.android") version "1.9.0" apply false

    // Plugin Google Services pour Firebase
    id("com.google.gms.google-services") version "4.4.4" apply false
}

allprojects {
    // Définition des dépôts nécessaires au projet Android et Firebase
    repositories {
        google()
        mavenCentral()
    }
}

// Redirection du dossier build global pour éviter les conflits avec Flutter
val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

// Appliquer la même configuration du build pour chaque sous-projet
subprojects {
    val newSubBuildDir = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubBuildDir)
}

// S’assurer que le module :app est chargé avant les autres
subprojects {
    project.evaluationDependsOn(":app")
}

// Nettoyage complet du build lors de la commande flutter clean
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
