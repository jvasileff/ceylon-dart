mkdir -p ~/.ceylon/repo/dart/async/1.3.1
mkdir -p ~/.ceylon/repo/dart/collection/1.3.1
mkdir -p ~/.ceylon/repo/dart/convert/1.3.1
mkdir -p ~/.ceylon/repo/dart/core/1.3.1
mkdir -p ~/.ceylon/repo/dart/developer/1.3.1
mkdir -p ~/.ceylon/repo/dart/io/1.3.1
mkdir -p ~/.ceylon/repo/dart/isolate/1.3.1
mkdir -p ~/.ceylon/repo/dart/math/1.3.1
mkdir -p ~/.ceylon/repo/dart/mirrors/1.3.1
mkdir -p ~/.ceylon/repo/dart/typed_data/1.3.1

cp -a modules/dart.async-1.3.1-dartmodel.json ~/.ceylon/repo/dart/async/1.3.1
cp -a modules/dart.collection-1.3.1-dartmodel.json ~/.ceylon/repo/dart/collection/1.3.1
cp -a modules/dart.convert-1.3.1-dartmodel.json ~/.ceylon/repo/dart/convert/1.3.1
cp -a modules/dart.core-1.3.1-dartmodel.json ~/.ceylon/repo/dart/core/1.3.1
cp -a modules/dart.developer-1.3.1-dartmodel.json ~/.ceylon/repo/dart/developer/1.3.1
cp -a modules/dart.io-1.3.1-dartmodel.json ~/.ceylon/repo/dart/io/1.3.1
cp -a modules/dart.isolate-1.3.1-dartmodel.json ~/.ceylon/repo/dart/isolate/1.3.1
cp -a modules/dart.math-1.3.1-dartmodel.json ~/.ceylon/repo/dart/math/1.3.1
cp -a modules/dart.mirrors-1.3.1-dartmodel.json ~/.ceylon/repo/dart/mirrors/1.3.1
cp -a modules/dart.typed_data-1.3.1-dartmodel.json ~/.ceylon/repo/dart/typed_data/1.3.1

touch ~/.ceylon/repo/dart/async/1.3.1/dart.async-1.3.1.dart
touch ~/.ceylon/repo/dart/collection/1.3.1/dart.collection-1.3.1.dart
touch ~/.ceylon/repo/dart/core/1.3.1/dart.core-1.3.1.dart
touch ~/.ceylon/repo/dart/developer/1.3.1/dart.developer-1.3.1.dart
touch ~/.ceylon/repo/dart/convert/1.3.1/dart.convert-1.3.1.dart
touch ~/.ceylon/repo/dart/io/1.3.1/dart.io-1.3.1.dart
touch ~/.ceylon/repo/dart/isolate/1.3.1/dart.isolate-1.3.1.dart
touch ~/.ceylon/repo/dart/math/1.3.1/dart.math-1.3.1.dart
touch ~/.ceylon/repo/dart/mirrors/1.3.1/dart.mirrors-1.3.1.dart
touch ~/.ceylon/repo/dart/typed_data/1.3.1/dart.typed_data-1.3.1.dart

rm -f ~/.ceylon/repo/dart/*/1.3.1/*sha1
