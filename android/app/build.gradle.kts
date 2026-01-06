plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
}

android {
    namespace = "com.ams.mobile"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.ams.mobile"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
    flavorDimensions += "default"
    productFlavors {
        create("prod") {
            dimension = "default"
            resValue("string", "app_name", "ams-mobile")
        }
        create("dev") {
            dimension = "default"
            resValue("string", "app_name", "ams-mobile-dev")
            applicationIdSuffix = ".dev"
        }
    }
}

// Copy the correct google-services.json based on the flavor
androidComponents {
    onVariants { variant ->
        val flavorName = variant.flavorName
        if (flavorName != null) {
            val googleServicesTask = tasks.register("copy${variant.name.capitalize()}GoogleServices", Copy::class) {
                from("src/$flavorName")
                include("google-services.json")
                into(".")
            }

            tasks.named("process${variant.name.capitalize()}GoogleServices") {
                dependsOn(googleServicesTask)
            }
        }
    }
}

flutter {
    source = "../.."
}
