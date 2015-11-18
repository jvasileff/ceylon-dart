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

class CeylonBasePlugin implements Plugin<Project> {
  void apply(Project project) {
    def ceylonHome
    if (project.hasProperty("${project.group}.ceylon.home")) {
      ceylonHome = project."${project.group}.ceylon.home"
    } else if (project.hasProperty("ceylon.home")) {
      ceylonHome = project."ceylon.home"
    } else {
      ceylonHome = "$System.env.CEYLON_HOME"
    }
    if (!(new File(ceylonHome).isDirectory())) {
      throw new GradleException(
           "Unable to determine Ceylon installation directory.\n" +
           "Please set one of the following properties:\n" +
           "    ${project.group}.ceylon.home\n" +
           "    ceylon.home\n" +
           "Or the environment variable CEYLON_HOME")
    }

    project.configurations.create("ceylon")
    project.dependencies {
      ceylon project.files("${ceylonHome}/lib/ceylon-ant.jar")
    }

    // require the base plugin
    project.getPlugins().apply(BasePlugin.class)

    // hack to not require package name in build.gradle
    project.ext.CompileCeylonTask = CompileCeylonTask
    project.ext.CompileCeylonJSTask = CompileCeylonJSTask
    project.ext.CeylonDocTask = CeylonDocTask
    project.ext.CeylonTestTask = CeylonTestTask
    project.ext.CeylonPluginPackTask = CeylonPluginPackTask

    // http://ceylon-lang.org/documentation/1.1/reference/tool/ant/
    project.ant.taskdef(resource: 'com/redhat/ceylon/ant/antlib.xml',
                        classpath: project.configurations.ceylon.asPath)
  }
}
