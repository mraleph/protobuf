package dev.dart.protobufspeed;

import java.nio.ByteBuffer;
import java.nio.file.FileSystems;
import java.nio.file.Files;
import java.nio.file.Path;

import crosby.binary.Osmformat.*;

/**
 * Hello world!
 *
 */
public class App
{
    public static void main( String[] args ) throws Exception
    {
        if (args.length != 1) {
            System.err.println("Usage: App <path/to/primitiveBlock.buf>");
            System.exit(1);
        }
        Path path = FileSystems.getDefault().getPath(args[0]);
        ByteBuffer bytes = ByteBuffer.wrap(Files.readAllBytes(path));

        for (int i = 0; i < 10; i++) {
            long start = System.currentTimeMillis();
            PrimitiveBlock.parseFrom(bytes);
            long end = System.currentTimeMillis();
            System.out.printf("%d took %d ms\n", i, (end - start));
        }
    }
}
