package io.github.linwancen.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
import java.io.IOException;

public class PathUtils {

    private PathUtils() {}

    private static final Logger LOG = LoggerFactory.getLogger(PathUtils.class);

    public static final String CLASS_PATH;

    static {
        @SuppressWarnings("ConstantConditions")
        String path = ClassLoader.getSystemClassLoader().getResource("").getPath();
        try {
            path = URLDecoder.decode(path, "UTF-8");
        } catch (Exception ignored) {
        }
        CLASS_PATH = path;
    }

    public static String canonicalPath(File file) {
        try {
            return file.getCanonicalPath().replace('\\', '/');
        } catch (IOException e) {
            String path = file.getAbsolutePath().replace('\\', '/');
            LOG.warn("getCanonicalPath IOException {}\nuse AbsolutePath file:///{}",
                    e.getLocalizedMessage(), path, e);
            return path;
        }
    }

    public static String dirSpaceName(String dirFile) {
        int nameIndex = dirFile.lastIndexOf('/') + 1;
        String dir = dirFile.substring(0, nameIndex);
        String name = dirFile.substring(nameIndex);
        return dir + " " + name;
    }
}
