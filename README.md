# Dart backend for Ceylon

## Update (11/22)

**A developer preview release (DP1) of the Dart backend for Ceylon has been
released!**

The DP1 release of the Dart backend supports a significant portion of the
Ceylon language specification 1.2.0, and can be used to compile and run
sophisticated Ceylon commandline applications on the Dart VM. In fact, most
existing Ceylon applications that use supported SDK modules (listed below) can
be compiled with very few changes.

There is a significant amount of "fit and finish" included in the DP1 release,
which heavily relies on Ceylon's excellent tools infrastructure.  Errors are
almost always presented as well formatted compiler errors, rather than ugly or
confusing stack traces, even for unfinished or unsupported features.

For anyone that is even mildly interested, there is no reason not to give it a
try! As you will see, installation and usage is *very* straightforward.

### Installing the Dart backend for Ceylon

The commandline interface for the Dart backend is available on [Ceylon Herd]
(https://modules.ceylon-lang.org/modules/com.vasileff.ceylon.dart.cli), and can
be easily installed on any OS X or Linux system.

**Step 1: Install Ceylon**

To install Ceylon, see <http://ceylon-lang.org/download/>. Ceylon 1.2.0 is required.

**Step 2: Install Dart**

[Homebrew](http://brew.sh) users on OS X can install Dart
[with](https://www.dartlang.org/downloads/mac.html):

    $ brew tap dart-lang/dart
    $ brew install dart

For Linux users, Dart is available as either a Debian package or zip download
from <https://www.dartlang.org/downloads/>.

**Step 3: Install the Ceylon/Dart CLI Plugin**

The Dart backend commandline interface can be installed with:

    $ ceylon plugin install com.vasileff.ceylon.dart.cli/1.2.0-DP1

And that's it!

*Please note that upon running the commandline tools the first time, additional
dependencies may be downloaded. No feedback is provided that this is happening,
and canceling early may result in a corrupted download. So please be patient!*

### Using the Commandline Interface

Commandline tools for compiling and running Ceylon programs on the Dart VM
mirror the tools used for the JVM and JavaScript backends:

- `ceylon compile-dart` to compile Ceylon modules to Dart
- `ceylon run-dart` to run compiled Ceylon modules on the Dart VM

A third tool, `ceylon assemble-dart`, packages Ceylon modules as standalone
executables for the Dart VM.

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

Of course, you'll want to write much more sophisticated programs that take full
advantage of Ceylon's advanced but easy to use type system and features.  To
learn more, see the [Ceylon language
tour](http://ceylon-lang.org/documentation/1.2/tour/).

You can also try Ceylon [online](http://try.ceylon-lang.org), but be sure to
copy the examples locally, and try them out on the Dart backend!

### SDK Modules Included in DP1

Several SDK modules are available in DP1 (and most of them actually work!):

- `ceylon.collection` provides general-purpose mutable lists, sets, and maps
- `ceylon.html` allows you to write HTML templates for both server and client using only Ceylon 
- `ceylon.json` contains everything required to parse and serialise JSON data
- `ceylon.math` provides common mathematical functions and the types `Whole` and `Long`
- `ceylon.promise` support for promises loosely based upon the A+ specification (\*)
- `ceylon.time` is a date and time library library that is loosely inspired by
  the JodaTime/JSR-310 library

(\*) Several try/catch statements have been commented out of `ceylon.promise`
for DP1, reducing its usefulness.

### Supported Language Features in DP1

The vast majority of the language constructs have been implemented. Notable
*exceptions* include:

- Destructuring
- Forward-declared functions
- Try/Catch/Finally (but `throw` is supported)
- `Object.string` and `Object.hash` implemented as _reference_ values
- Capture of `variable` values
- Spread attribute and spread method operators (`lhs*.member` expressions)
- Value constructors
- Extending a constructor with another constructor
- Type families (polymorphic member classes)

In practice, most existing code can be compiled after implementing workarounds
for the first few items, with the remaining items occuring in real world code
less frequently.

There are two significant overarching features have not yet been implemented:

- Reified generics
- The metamodel

Code that relies on reified generics may produce incorrect results. For
instance, the expression `x is List<String>` will evaluate to `true` if `x` is
*any* `List`, for example `List<Integer>`. Tests on unions (like `x is String |
Integer`) and intersections (like `x is Obtainable & Serializable`) do work
correctly.

## Update (10/27)

Quite a bit of the core of the backend has been completed:

- The Ceylon language module compiles with very few changes.
- A first cut of much of the native Dart code necessary for the main package of
  the Ceylon language module has been written.
- Fairly complex CLI programs can now be compiled and run using the standard
  Ceylon commandline interface (i.e. `ceylon compile-dart com.example.module`
  and `ceylon run-dart com.example.module`).

Soon, installation instructions and easy to run code samples will be posted.

Some small, but mostly "big" tasks that remain:

- Improve and complete native Dart code for the core part of the language
  module.
- Improve tools, including performance, warning and error reporting, and CLI
  options.
- Round out support for core language features–destructuring, capture of
  `variable`s, certain uses of specification statements, constructor
  delegation, class aliases, etc.
- Compile `ceylon.collection`
- Add a model loader and support module imports. (Aside from the implicit
  language module import, which works today.)
- Implement the metamodel (`ceylon.language.meta` and meta expressions)
- Support Annotations
- Implement reified generics
- Develop an interop story (calling Dart libraries from Ceylon)

### License

The content of this repository is released under the ASL v2.0 as provided in
the LICENSE file that accompanied this code.

By submitting a "pull request" or otherwise contributing to this repository,
you agree to license your contribution under the license mentioned above.
