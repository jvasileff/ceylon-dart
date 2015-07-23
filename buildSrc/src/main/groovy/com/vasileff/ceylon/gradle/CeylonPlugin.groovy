package com.vasileff.ceylon.gradle

import org.gradle.api.DefaultTask
import org.gradle.api.Plugin
import org.gradle.api.Project
import org.gradle.api.GradleException
import org.gradle.api.file.FileCollection
import org.gradle.api.plugins.BasePlugin
import org.gradle.api.tasks.Copy
import org.gradle.api.tasks.InputFiles
import org.gradle.api.tasks.InputDirectory
import org.gradle.api.tasks.OutputDirectory
import org.gradle.api.tasks.TaskAction
import org.gradle.util.GUtil
import org.apache.tools.ant.types.Path

class CeylonPlugin implements Plugin<Project> {
  void apply(Project project) {
    // require the base plugin
    project.getPlugins().apply(CeylonBasePlugin.class)

    ["main", "test"].each { sourceSet ->
      // ceylonCompile Task
      def srcDir = project.file("src/${sourceSet}/ceylon")
      def destDir = new File(project.buildDir, "modules-jvm/${sourceSet}")
      def taskName
      if (sourceSet == "main") {
        taskName = "compileCeylon"
      } else {
        taskName = "compile${sourceSet.capitalize()}Ceylon"
      }
      def compileTask = project.task([
                type: CompileCeylonTask,
                group: 'Build',
                description: "Compile the '${sourceSet}' Ceylon modules."],
                taskName)

      compileTask.destinationDir destDir
      compileTask.sourceDir srcDir
    }

    project.assemble.dependsOn project.compileCeylon

    // ceylonDoc will pick up compileCeylon's source directories
    getOrCreateCeylonDocTask(project).dependsOn project.compileCeylon
  }

  static CeylonDocTask getOrCreateCeylonDocTask(Project project) {
    def docTaskName = "ceylonDoc"
    def ceylonDoc = project.tasks.findByPath(docTaskName)
    if (ceylonDoc == null) {
      ceylonDoc = project.task([
            type: CeylonDocTask,
            group: 'Documentation',
            description: "Generates documentation for the 'main' Ceylon modules."],
            docTaskName)
      ceylonDoc.destinationDir = "${project.buildDir}/modules-doc/main"
      project.assemble.dependsOn ceylonDoc
    }
    return ceylonDoc
  }
}
