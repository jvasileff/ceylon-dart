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

abstract class AbstractCeylonTask extends DefaultTask {
  protected Set<String> modules = new HashSet()
  private List<Object> source = new ArrayList<Object>();

  String encoding = 'UTF-8'
  def destinationDir

  @InputFiles
  protected FileCollection getInputFiles() {
    // https://issues.gradle.org/browse/GRADLE-3051
    project.files(getSourceDirs());
  }

  protected Path getAntSourcePath() {
    ant.path {
      getSourceDirs().each {
        pathelement(location: it)
      }
    }
  }

  protected Set<File> additionalSourceDirs() {
    return new HashSet<File>()
  }

  Set<File> getSourceDirs() {
    Set<File> dirs = new LinkedHashSet<File>()
    source.each {
      def file = project.file(it)
      if (file.isDirectory()) {
        dirs.add(file)
      }
    }
    dirs.addAll(additionalSourceDirs())
    dirs
  }

  void setSourceDirs(Iterable<?> srcDirs) {
    source.clear()
    GUtil.addToCollection(source, srcDirs)
  }

  void sourceDir(Object srcDir) {
    source.add(srcDir)
  }

  void sourceDirs(Object... srcDirs) {
    srcDirs.each {
      source.add(it)
    }
  }

  @OutputDirectory
  File getDestination() {
    project.file(destinationDir)
  }

  void module(String module) {
    modules.add(module)
  }

  void modules(List<String> modules) {
    modules.each {
      module(it)
    }
  }
}

class CompileCeylonTask extends AbstractCeylonTask {
  @TaskAction
  def compile() {
    def sources = getSourceDirs();
    if (!sources.empty) {
      ant."ceylon-compile"(
            src: getAntSourcePath(),
            out: getDestination(),
            encoding: encoding,
            nomtimecheck: false) {
        moduleset {
          if (!modules.empty) {
            modules.each {
              module(name: it)
            }
          } else {
            sources.each {
              sourcemodules(dir: it)
            }
          }
        }
      }
    }
  }
}

class CompileCeylonJSTask extends AbstractCeylonTask {
  @TaskAction
  def compile() {
    def sources = getSourceDirs();
    if (!sources.empty) {
      ant."ceylon-compile-js"(
            src: getAntSourcePath(),
            out: getDestination(),
            encoding: encoding,
            nomtimecheck: false) {
        moduleset {
          if (!modules.empty) {
            modules.each {
              module(name: it)
            }
          } else {
            sources.each {
              sourcemodules(dir: it)
            }
          }
        }
      }
    }
  }
}

class CeylonDocTask extends AbstractCeylonTask {
  Boolean includeSource = false

  Set<File> additionalSourceDirs() {
    Set<File> dirs = new HashSet<File>()
    dependsOn.each {
      if (it instanceof AbstractCeylonTask) {
        dirs.addAll(it.getSourceDirs())
      }
    }
    return dirs
  }

  @TaskAction
  def compile() {
    def sources = getSourceDirs();
    if (!sources.empty) {
      ant."ceylon-doc"(
            src: getAntSourcePath(),
            out: getDestination(),
            encoding: encoding,
            includeSourceCode: includeSource,
            nomtimecheck: false) {
        moduleset {
          if (!modules.empty) {
            modules.each {
              module(name: it)
            }
          } else {
            sources.each {
              sourcemodules(dir: it)
            }
          }
        }
      }
    }
  }
}
