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
  private List<String> repos = new ArrayList<String>()

  protected Path getAntSourcePath() {
    ant.path {
      getSourceDirs().each {
        pathelement(location: it)
      }
    }
  }

  protected Path getAntScriptPath() {
    ant.path {
      getScriptDirs().each {
        pathelement(location: it)
      }
    }
  }

  void module(String module) {
    modules.add(module)
  }

  void modules(List<String> modules) {
    modules.each {
      module(it)
    }
  }

  protected Set<String> additionalRepositories() {
    return new HashSet<String>()
  }

  void repository(Object repository) {
    // may be a String or File
    repos.add(repository.toString())
  }

  void repositories(List<String> repositories) {
    repositories.each {
      repository(it)
    }
  }

  Set<String> getRepositories() {
    Set<String> repositories = new LinkedHashSet<String>()
    repos.each {
      repositories.add(it)
    }
    repositories.addAll(additionalRepositories())
    repositories
  }
}

abstract class AbstractOutputtingCeylonTask extends AbstractCeylonTask {
  private List<Object> source = new ArrayList<Object>();
  private List<Object> script = new ArrayList<Object>();
  private List<Object> resource = new ArrayList<Object>();

  String encoding = 'UTF-8'
  def destinationDir

  @InputFiles
  protected FileCollection getInputFiles() {
    // https://issues.gradle.org/browse/GRADLE-3051
    project.files(getSourceDirs() + getResourceDirs() + getScriptDirs());
  }


  protected Set<File> additionalSourceDirs() {
    return new HashSet<File>()
  }

  protected Set<File> additionalScriptDirs() {
    return new HashSet<File>()
  }

  protected Set<File> additionalResourceDirs() {
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

  Set<File> getScriptDirs() {
    Set<File> dirs = new LinkedHashSet<File>()
    script.each {
      def file = project.file(it)
      if (file.isDirectory()) {
        dirs.add(file)
      }
    }
    dirs.addAll(additionalScriptDirs())
    dirs
  }

  Set<File> getResourceDirs() {
    Set<File> dirs = new LinkedHashSet<File>()
    resource.each {
      def file = project.file(it)
      if (file.isDirectory()) {
        dirs.add(file)
      }
    }
    dirs.addAll(additionalResourceDirs())
    dirs
  }

  void setSourceDirs(Iterable<?> srcDirs) {
    source.clear()
    GUtil.addToCollection(source, srcDirs)
  }

  void setScriptDirs(Iterable<?> srcDirs) {
    script.clear()
    GUtil.addToCollection(script, srcDirs)
  }

  void setResourceDirs(Iterable<?> srcDirs) {
    source.clear()
    GUtil.addToCollection(source, srcDirs)
  }

  void sourceDir(Object srcDir) {
    source.add(srcDir)
  }

  void scriptDir(Object srcDir) {
    script.add(srcDir)
  }

  void resourceDir(Object srcDir) {
    resource.add(srcDir)
  }

  void sourceDirs(Object... srcDirs) {
    srcDirs.each {
      source.add(it)
    }
  }

  void scriptDirs(Object... srcDirs) {
    srcDirs.each {
      script.add(it)
    }
  }

  void resourceDirs(Object... srcDirs) {
    srcDirs.each {
      source.add(it)
    }
  }

  @OutputDirectory
  File getDestination() {
    project.file(destinationDir)
  }
}

class CompileCeylonTask extends AbstractOutputtingCeylonTask {

  Set<File> additionalRepositories() {
    List<String> dirs = new ArrayList<String>()

    // FIXME this doesn't work if dependencies are configured using Strings.
    dependsOn.each {
      if (it instanceof AbstractOutputtingCeylonTask) {
        dirs.add(it.destinationDir.toString())
      }
    }
    return dirs
  }

  @TaskAction
  def compile() {
    def sources = getSourceDirs();
    def resources = getResourceDirs();
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
        if (!getRepositories().empty) {
          reposet {
            getRepositories().each {
              repo(url: it)
            }
          }
        }
        if (!resources.empty) {
          resources.each {
            resource(it)
          }
        }
      }
    }
  }
}

class CompileCeylonJSTask extends AbstractOutputtingCeylonTask {
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

class CeylonDocTask extends AbstractOutputtingCeylonTask {
  Boolean includeSource = false
  Boolean includeNonShared = false
  Boolean ignoreBrokenLink = false;
  Boolean ignoreMissingDoc = false;
  Boolean ignoreMissingThrows = false;

  Set<File> additionalRepositories() {
    List<String> dirs = new ArrayList<String>()

    // FIXME this doesn't work if dependencies are configured using Strings.
    dependsOn.each {
      if (it instanceof AbstractOutputtingCeylonTask) {
        it.each {
          if (it instanceof AbstractOutputtingCeylonTask) {
            // TODO add all of the task's repositories, too
            //      and... not sure if this works
            dirs.add(it.destinationDir.toString())
          }
        }
      }
    }
    return dirs
  }

  Set<File> additionalSourceDirs() {
    Set<File> dirs = new HashSet<File>()
    dependsOn.each {
      if (it instanceof AbstractOutputtingCeylonTask) {
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
            includeNonShared: includeNonShared,
            ignoreMissingDoc: ignoreMissingDoc,
            ignoreMissingThrows: ignoreMissingThrows,
            ignoreBrokenLink: ignoreBrokenLink,
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
        if (!getRepositories().empty) {
          reposet {
            getRepositories().each {
              repo(url: it)
            }
          }
        }
      }
    }
  }
}

class CeylonPluginPackTask extends AbstractOutputtingCeylonTask {
  String group = "Build"
  String description = "Packs scripts defined by the module."

  Set<File> additionalRepositories() {
    List<String> dirs = new ArrayList<String>()

    // FIXME this doesn't work if dependencies are configured using Strings.
    dependsOn.each {
      if (it instanceof AbstractOutputtingCeylonTask) {
        it.each {
          if (it instanceof AbstractOutputtingCeylonTask) {
            // TODO add all of the task's repositories, too
            //      and... not sure if this works
            dirs.add(it.destinationDir.toString())
          }
        }
      }
    }
    return dirs
  }

  Set<File> additionalSourceDirs() {
    Set<File> dirs = new HashSet<File>()
    return dirs
  }

  Set<File> additionalScriptDirs() {
    Set<File> dirs = new HashSet<File>()
    dependsOn.each {
      if (it instanceof AbstractOutputtingCeylonTask) {
        dirs.addAll(it.getScriptDirs())
      }
    }
    return dirs
  }

  @TaskAction
  def compile() {
    def scripts = getScriptDirs();
    if (!scripts.empty) {
      ant."ceylon-plugin"(
            mode: "pack",
            script: getAntScriptPath(),
            out: getDestination()) {
        moduleset {
          if (!modules.empty) {
            modules.each {
              module(name: it)
            }
          }
        }
        if (!getRepositories().empty) {
          reposet {
            getRepositories().each {
              repo(url: it)
            }
          }
        }
      }
    }
  }
}

class CeylonTestTask extends AbstractCeylonTask {
  String group = "Verification"
  String description = "Run Ceylon unit tests."

  Boolean report = false

  protected Set<String> tests = new HashSet()
  void test(String test) {
    tests.add(test)
  }

  void tests(List<String> tests) {
    tests.each {
      test(it)
    }
  }

  Set<File> additionalRepositories() {
    List<String> dirs = new ArrayList<String>()

    // FIXME this doesn't work if dependencies are configured using Strings.
    dependsOn.each {
      if (it instanceof AbstractOutputtingCeylonTask) {
        dirs.add(it.destinationDir.toString())
      }
    }
    return dirs
  }

  @TaskAction
  def compile() {
    ant."ceylon-test"(
            report: report) {
      tests.each {
        test(test: it);
      }
      moduleset {
        if (!modules.empty) {
          modules.each {
            module(name: it)
          }
        }
      }
      if (!getRepositories().empty) {
        reposet {
          getRepositories().each {
            repo(url: it)
          }
        }
      }
    }
  }
}
