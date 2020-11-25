import 'dart:io';

import 'package:osm_benchmark/src/generated/osmformat.pb.dart';

main(List<String> args) {
  if (args.length != 1) {
    print('Usage: main.dart <path/to/primitiveBlock.buf>');
    exit(1);
  }

  final bytes = File(args.first).readAsBytesSync();
  print('loaded ${bytes.length} bytes from ${args.first}');

  for (var i = 0; i < 10; i++) {
    final sw = Stopwatch()..start();
    PrimitiveBlock.fromBuffer(bytes);
    print('$i: ${sw.elapsedMilliseconds} ms');
  }
}
