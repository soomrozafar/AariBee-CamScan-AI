
import com.android.build.gradle.BaseExtension
import org.gradle.api.file.Directory
import org.gradle.api.tasks.Delete

allprojects {

    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()

rootProject.layout.buildDirectory
    .value(newBuildDir)

subprojects {

    val newSubprojectBuildDir:
        Directory =
            newBuildDir.dir(
                project.name,
            )

    project.layout.buildDirectory
        .value(
            newSubprojectBuildDir,
        )

    project.evaluationDependsOn(
        ":app",
    )

    plugins.withId(
        "com.android.library",
    ) {

        extensions.configure<
            BaseExtension
        > {

            compileSdkVersion(
                36,
            )
        }
    }

    plugins.withId(
        "com.android.application",
    ) {

        extensions.configure<
            BaseExtension
        > {

            compileSdkVersion(
                36,
            )
        }
    }
}

tasks.register<Delete>(
    "clean",
) {

    delete(
        rootProject.layout
            .buildDirectory,
    )
}

