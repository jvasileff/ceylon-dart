import "dart:core" as $dart$core;
import "dart:math" as $dart$math;
import "../../../../../../ceylon-dart/ceylon-dart-language/ceylon.language.dart" as $ceylon$language;

$dart$core.double float$exp($dart$core.double num) => $dart$math.exp(num);
$dart$core.double $package$float$exp($dart$core.double num) => float$exp(num);

$dart$core.double float$log($dart$core.double num) => $dart$math.log(num);
$dart$core.double $package$float$log($dart$core.double num) => float$log(num);

$dart$core.double float$log10($dart$core.double num) => $dart$math.log(num) / $dart$math.LN10;
$dart$core.double $package$float$log10($dart$core.double num) => float$log10(num);

$dart$core.double float$sin($dart$core.double num) => $dart$math.sin(num);
$dart$core.double $package$float$sin($dart$core.double num) => float$sin(num);

$dart$core.double float$cos($dart$core.double num) => $dart$math.cos(num);
$dart$core.double $package$float$cos($dart$core.double num) => float$cos(num);

$dart$core.double float$tan($dart$core.double num) => $dart$math.tan(num);
$dart$core.double $package$float$tan($dart$core.double num) => float$tan(num);

$dart$core.double float$asin($dart$core.double num) => $dart$math.asin(num);
$dart$core.double $package$float$asin($dart$core.double num) => float$asin(num);

$dart$core.double float$acos($dart$core.double num) => $dart$math.acos(num);
$dart$core.double $package$float$acos($dart$core.double num) => float$acos(num);

$dart$core.double float$atan($dart$core.double num) => $dart$math.atan(num);
$dart$core.double $package$float$atan($dart$core.double num) => float$atan(num);

$dart$core.double float$atan2($dart$core.double y, $dart$core.double x) => $dart$math.atan2(y, x);
$dart$core.double $package$float$atan2($dart$core.double y, $dart$core.double x) => float$atan2(y, x);

$dart$core.double float$sqrt($dart$core.double num) => $dart$math.sqrt(num);
$dart$core.double $package$float$sqrt($dart$core.double num) => float$sqrt(num);

$dart$math.Random _$random = new $dart$math.Random();
$dart$core.double float$random() => _$random.nextDouble();
$dart$core.double $package$float$random() => float$random();
