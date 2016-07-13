# Dart backend for Ceylon

## Update (7/13/2016)

**Developer preview release 2 (DP2) of the Dart backend for Ceylon is now
available**

This release includes:

- Complete support for the [Ceylon 1.2.2](http://ceylon-lang.org) language,
  except reified generics and the metamodel.
- A familiar CLI for compiling and running Ceylon programs (`ceylon
  compile-dart` and `ceylon run-dart`).
- A powerful application assembly tool (`ceylon assemble-dart`) that can
  produce distributable Dart VM applications, single file Dart VM applications,
  and single file JavaScript applications.
- Eleven Ceylon SDK modules
- Initial support for Dart interop, including async/await, the
  `ceylon.interop.dart` module, and the ability to import and use 11 native
  Dart modules such as `dart.core`, `dart.collection`, and `dart.html`.

## Installing the Dart backend for Ceylon

The commandline interface for the Dart backend is available on [Ceylon Herd]
(https://modules.ceylon-lang.org/modules/com.vasileff.ceylon.dart.cli), and can
be easily installed on any OS X or Linux system.

**Step 1: Install Ceylon**

To install Ceylon, see <http://ceylon-lang.org/download/>. Ceylon 1.2.2 is required.

**Step 2: Install Dart**

[Homebrew](http://brew.sh) users on OS X can install Dart
[with](https://www.dartlang.org/downloads/mac.html):

    $ brew tap dart-lang/dart
    $ brew install dart

For Linux users, Dart is available as either a Debian package or zip download
from <https://www.dartlang.org/downloads/>.

**Step 3: Install the Ceylon/Dart CLI Plugin**

The commandline interface can be installed with:

    $ ceylon plugin install com.vasileff.ceylon.dart.cli/1.2.2-DP2

Upon using `ceylon compile-dart` or `ceylon run-dart` for the first time, you
will be prompted to complete the installation by running:

    $ ceylon install-dart --out +USER

This will install the Ceylon language module, several Ceylon SDK modules, and
several Dart interop modules into your local Ceylon module repository, which,
for default Ceylon installations, is located at `~/.ceylon/repo`.

And that's it!

*Please note that upon running the commandline tools the first time, additional
dependencies may be downloaded. No feedback is provided that this is happening,
and canceling early may result in a corrupted download. So please be patient!*

## Using the Commandline Interface

Commandline tools for compiling and running Ceylon programs on the Dart VM
mirror the tools used for the JVM and JavaScript backends:

- `ceylon compile-dart` to compile Ceylon modules to Dart
- `ceylon run-dart` to run compiled Ceylon modules on the Dart VM

A third tool, `ceylon assemble-dart`, package a Ceylon module as a standalone
executable for the Dart VM.

## Ok, it's installed, what do I do now?

There are three main types of applications that can be written today:

- command line applications,
- web client (JavaScript) applications using `dart.html`, and
- server side applications using `dart.io`

Support for pure-Ceylon CLI applications is quite advanced and supports nearly
all valid Ceylon 1.2.2 programs. Modules can be compiled, run, and even
imported using standard Ceylon tools and conventions. See the "Hello, World"
walkthrough below to get started.

Check back soon for more on building server and web applications. For now, you
might want to check out
[ColorTrompon](https://github.com/jvasileff/ColorTrompon), which is a Ceylon
syntax highligher, written in Ceylon, compiled with `ceylon compile-dart colortrompon`, and
packaged as a JavaScript application with `ceylon assemble-dart mode=js colortrompon`.

### "Hello, World" Walkthrough

If you're new to Ceylon, you can perform the following steps to compile and run
your first program.

First, use the `ceylon new` command to create an initial project structure:

    $ ceylon new hello-world
    Enter project folder name [helloworld]: 
    Enter module name [com.example.helloworld]: 
    Enter module version [1.0.0]: 
    Would you like to generate Eclipse project files? (y/n) [y]: 
    Enter Eclipse project name [com.example.helloworld]: 
    Would you like to generate an ant build.xml? (y/n) [y]: 

    $ cd helloworld/

In the newly created helloworld directory, you will find
`source/com/example/helloworld` containing the main `run.ceylon` source code
along with `module.ceylon` and `package.ceylon` module and package descriptors.

Now, from within the `helloworld` directory, the program can be compiled with:

    $ ceylon compile-dart
    Note: Created module com.example.helloworld/1.0.0

which creates a `modules` directory, and places the Dart output in the file
`modules/com/.../com.example.helloworld-1.0.0.dart`

Run the program with the `ceylon run` command, specifying the module name and
arguments:

    $ ceylon run-dart com.example.helloworld 'Ceylon on Dart'
    Hello, Ceylon on Dart!

Or, if you like, create a single-file application:

    $ ceylon assemble-dart --out helloworld com.example.helloworld
    Created executable Dart script helloworld

and run as you would any other executable:

    $ ./helloworld 'Ceylon on Dart, without the Java!!'
    Hello, Ceylon on Dart, without the Java!!!

Of course, you'll want to write much more sophisticated programs that take
advantage of Ceylon's advanced but easy to use type system and features. To
learn more, see the [Ceylon language
tour](http://ceylon-lang.org/documentation/1.2/tour/).

You can also try Ceylon [online](http://try.ceylon-lang.org), but be sure to
copy the examples locally, and try them out on the Dart backend!

#### About the `ceylon new` Command

Note that the `ceylon new` command is not Dart specific; it is a standard
command available with Ceylon 1.2.2. For help using the command, use `ceylon
help new`.

You may notice options to create Eclipse and Ant configuration files. While
Eclipse and Ant support is not currently available for the Dart backend, these
options may still be useful, as you might use Eclipse to develop a module using
the Java or JavaScript backend, and then drop to the CLI to compile for Dart.

Also note that the first argument to `ceylon new` must be the name of a
template. Of the three templates available as part of Ceylon 1.2.2,
`hello-world` and `simple` can be used for Dart projects. For example, to get
started with a blank project, you might use:

    ceylon new simple --module-name=com.mydomain.myproject myprojectDir

## Ceylon/Dart DP2 Release Details

### SDK Modules Included in DP2

Several Ceylon SDK modules ship with DP2:

- `ceylon.buffer` allows you to convert between text and binary forms of data
- `ceylon.collection` provides general-purpose mutable lists, sets, and maps
- `ceylon.html` allows you to write HTML templates for both server and client using only Ceylon 
- `ceylon.interop.dart` types and utilities to work with native Dart code and libraries,
- `ceylon.json` contains everything required to parse and serialise JSON data
- `ceylon.numeric` provides common math functions for floats and integers
- `ceylon.promise` support for promises loosely based upon the A+ specification
- `ceylon.random` provides a pseudorandom number generator and extendable API
- `ceylon.test` simple framework to write repeatable tests
- `ceylon.time` is a date and time library library that is loosely inspired by
  the JodaTime/JSR-310 library
- `ceylon.whole` provides arbitrary-precision integer numeric type

### Dart Interop Modules Included in DP2

Several Dart modules can be imported by DP2 programs:

- `dart.async`
- `dart.collection`
- `dart.convert`
- `dart.core`
- `dart.developer`
- `dart.html`
- `dart.io`
- `dart.isolate`
- `dart.math`
- `dart.mirrors`
- `dart.typed_data`

## License

The content of this repository is released under the ASL v2.0 as provided in
the LICENSE file that accompanied this code.

By submitting a "pull request" or otherwise contributing to this repository,
you agree to license your contribution under the license mentioned above.
