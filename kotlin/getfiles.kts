package getfiles;

import java.io.File;
import kotlin.io.*;

val INDENTATION_LEVEL = 2

val IGNORED_PATHS = listOf("..", ".", ".git", "node_modules", "dist", ".dub");

fun printFiles(traversalLevel: Int, currentDirectory: File) {
    currentDirectory.walk().maxDepth(1).forEach {
        if (IGNORED_PATHS.contains(it.getName())) return@forEach;

        println(" ".repeat(traversalLevel * INDENTATION_LEVEL) + it.getName());
        if (it.isDirectory()) {
            val currentPath = currentDirectory.getCanonicalPath() + "/" + it.getName() + "/."
            printFiles(traversalLevel + 1, File(currentPath))
        }
    }
}

printFiles(0, File(".."))

// Local Variables:
// compile-command: "kotlinc -script getfiles.kts"
// End:
