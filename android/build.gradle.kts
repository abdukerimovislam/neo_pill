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
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

// 🚀 СНАЧАЛА РЕГИСТРИРУЕМ ХУК (ДО ВЫЧИСЛЕНИЯ)
subprojects {
    afterEvaluate {
        val androidExt = project.extensions.findByName("android") as? com.android.build.gradle.BaseExtension
        if (androidExt != null && androidExt.namespace == null) {
            androidExt.namespace = project.group.toString()
        }
    }
}

// 🚀 ТОЛЬКО ПОТОМ ДЕЛАЕМ EVALUATION DEPENDS ON
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}