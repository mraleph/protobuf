Benchmark for https://github.com/dart-lang/sdk/issues/44175

Requires `primitiveBlock.buf` from
https://github.com/dart-lang/protobuf/files/5478182/primitiveBlock.zip
to be unpacked somewhere. In the rest of this file we assume that it is
unpacked at `$PATH_TO_PRIMITIVE_BLOCK_BUF`.

We also assume that `$PROTOBUF_DIR` variable contains path to a directory
containing `protobuf` monorepo checkout. Path to this `README.md` file should
be `$PROTOBUF_DIR/protobuf/benchmarks/osm_benchmark/README.md`.

# Running Dart version

```console
$ cd $PROTOBUF_DIR/protobuf/benchmarks/osm_benchmark/dart
$ pub get
$ dart bin/main.dart $PATH_TO_PRIMITIVE_BLOCK_BUF
```
## Regenerating protobuf files for Dart version

If you want to do changes to `protoc_plugin` then you need to regenerate
protobuf files in `lib/src/generated`.

For that you need to clone `https://github.com/openstreetmap/OSM-binary.git`
somewhere (assuming at `$OSM_BINARY_DIR`).

Then you do the following while in `$PROTOBUF_DIR/protobuf/benchmarks/osm_benchmark/dart` directory.

```console
$ cd $PROTOBUF_DIR/protobuf/benchmarks/osm_benchmark/dart
$ pub global activate --source path $PROTOBUF_DIR/protoc_plugin
$ export PATH="$PATH":"$HOME/.pub-cache/bin"
$ protoc --proto_path=$OSM_BINARY_DIR/src --dart_out=lib/src/generated $OSM_BINARY_DIR/src/osmformat.proto
```

# Running Java version

You would need Maven (`apt-get install maven`). Then you can do:

```console
$ cd $PROTOBUF_DIR/protobuf/benchmarks/osm_benchmark/java
$ mvn compile
$ mvn exec:java -Dexec.mainClass="dev.dart.protobufspeed.App" \
  -Dexec.arguments="$PATH_TO_PRIMITIVE_BLOCK_BUF"
```


