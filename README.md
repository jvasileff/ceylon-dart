# Dart backend for Ceylon

### Status Update (10/27)

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

### Approach

- Keep things simple. Don't over (or under) optimize.
- Write as much code in Ceylon as possible. Prefer Ceylon language module code
  to native Dart code.
- Avoid use of the typechecker's `Tree`. Instead, use the Ceylon AST along with
  an abstraction to obtain model objects.
- Don't be lazy. Take full advantage of Dart's optional typing.
- Really, don't be lazy. All Dart code should compile without warnings and run
  in checked mode.
- A good analogy for the desired style of generated Dart code may be Java 1.0
  plus closures. Or, put another way, Java 8 without generics and inner classes
  and interfaces. Covariant generics may be added.

### License

The content of this repository is released under the ASL v2.0 as provided in
the LICENSE file that accompanied this code.

By submitting a "pull request" or otherwise contributing to this repository,
you agree to license your contribution under the license mentioned above.
