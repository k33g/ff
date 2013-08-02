package ff;

import ff.golo.tools.Resources;
import ff.golo.tools.ScriptsLoader;

import java.io.File;
import java.io.IOException;

/*
 User: k33g_org
 Date: 27/07/13
 Time: 10:14
*/
public class Reload {
    public static void all(String appDirectory) throws Exception {
        final ScriptsLoader scriptsLoader = new ScriptsLoader((new File(appDirectory)).getAbsolutePath());

        /* Load golo extensions (in jar file) */
        Resources.loadGoloExtensions(scriptsLoader);

        /* Load all external golo scripts (in app directory) */
        scriptsLoader.loadAll();

        /* boot and routes ... terminate */
        Resources.loadAndRunBootAndRoutesGoloScripts(scriptsLoader);


        Runtime.getRuntime().removeShutdownHook(Parameters.terminate);

        Resources.loadTerminateGoloScript(scriptsLoader);


        Runtime.getRuntime().addShutdownHook(Parameters.terminate);
    }
}
