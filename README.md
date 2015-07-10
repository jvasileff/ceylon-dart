# Dart backend for Ceylon

### Why?

The best answer is probably, why not?

A primary goal is to get started writing *some* backend in Ceylon, or at least
a reasonable portion of one, with the idea to pivot to something really useful.
Or at least try to explore and work through issues involved with writing a
backend in Ceylon to help lay the groundwork for others.

That's not to say that a Dart backend may not be valuable. The Dart VM
certainly appears to be fast, and the Dart language seems very suitable for use
as a transpiler target.

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

### Short Term, Course Grained Goals

- Round out support for simple functions
- Chip away at compiling language module functions
- Simple Interfaces & Classes
- CLI and proper compilation of source files (currently, programs are Strings
  in a run function.)
- Model loader of some sort. Maybe just hardcoded stuff

### Short Term, Fine Grained Tasks

Checked items are complete in the sense that they offer basic functionality.
Checking off "Base Expressions" for instance does *not* mean that they are
completely finished, or even 30% finished!

- [x] Multiple parameter lists
- [ ] Remaining parameter types (variadic, callable)
- [ ] Base expressions for objects
- [ ] `of` operation
- [ ] More work on `assert`
- [ ] `is` narrowing for `if`, attempt at generalization
- [ ] Erasure for covariant returns (use the `formal` return type for erasure/boxing)
- [ ] Named argument invocations (and... transition to Dart named parameters, ugh)
- [ ] Consider adding concept of "effective type" to erasure/boxing/casting logic,
  which would be a Ceylon type representative of the Dart type. For example,
  this would be `Anything` for generics, most unions, and intersections.
- [ ] Remove hard-coded `DartTypeName`s. Calculate them instead, as we do for
  Ceylon types. (We can't compile the language module using the prefixed
  `$dart$core.int` for example.)
- [ ] Map members like `toString()`, `hash`, etc.
- [ ] Statements & Expressions: for, if, while, then/else
- [ ] Use compiler for language module functions: `corresponding`, `count`,
  `every`, ~~identity~~, `noop`, ~~identical~~, `max`, `nothing`, ~~plus~~,
  `printAll`, `product`, ~~smallest~~, `sort`, `sum`, `times`.
- [ ] Integer -> Float conversion issues?
- [ ] Standalone declarations

A few recently completed items:

- [x] Base expressions
- [x] Qualified expressions
- [x] Take references to functions and methods
- [x] Wrap Dart `Function`s in `Callable`s, when necessary!
- [x] Parameter references
- [x] Emit `$package$` aliases for toplevels
- [x] Change type of defaulted parameters to `$dart$core.Object`, since their
  default value is a placeholder value
- [x] Use `as` for invocations when the Dart static type requires narrowing.
- [x] Use `as` whenever defaulted parameters are used (since they are now just Objects)
- [x] Use `as` everywhere it's needed, always.

## License

The content of this repository is released under the ASL v2.0 as provided in
the LICENSE file that accompanied this code.

By submitting a "pull request" or otherwise contributing to this repository,
you agree to license your contribution under the license mentioned above.
