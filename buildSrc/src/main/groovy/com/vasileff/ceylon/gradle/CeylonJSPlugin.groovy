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

class CeylonJSPlugin implements Plugin<Project> {
  void apply(Project project) {
    // require the base plugin
    project.getPlugins().apply(CeylonBasePlugin.class)

    ["main", "test"].each { sourceSet ->
      // ceylonCompile Task
      def srcDir = project.file("src/${sourceSet}/ceylon")
      def destDir = new File(project.buildDir, "modules-js/${sourceSet}")
      def taskName
      if (sourceSet == "main") {
        taskName = "compileCeylonJS"
      } else {
        taskName = "compile${sourceSet.capitalize()}CeylonJS"
      }
      def compileTask = project.task([
                type: CompileCeylonJSTask,
                group: 'Build',
                description: "Compile the '${sourceSet}' Ceylon modules."],
                taskName)

      compileTask.destinationDir destDir
      compileTask.sourceDir srcDir
    }

    project.assemble.dependsOn project.compileCeylonJS;

    // ceylonDoc will pick up compileCeylonJS's source directories
    CeylonPlugin.getOrCreateCeylonDocTask(project).dependsOn project.compileCeylonJS
  }
}

