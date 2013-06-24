package ff;

import ff.golo.tools.ScriptsLoader;
import java.io.File;

/*
 User: k33g_org
 Date: 24/06/13
 Time: 08:12
*/
public class Main {
    /*
        TODO :
         - arguments to change path of application
         - file parameters (configuration)
         - resources package (with logo etc. ...)
    */
    public static void main(String[] args) {

        ScriptsLoader scriptsLoader = new ScriptsLoader((new File("app")).getAbsolutePath());

        /* Load golo extensions (in jar file) */

        scriptsLoader.loadGoloResource("ff/golo/extensions/", "ext.futures.golo");

        /* Load all external golo scripts (in app directory) */

        scriptsLoader.loadAll();

        /* run boot and routes */
        try {
            scriptsLoader.module("/boot.golo")
                    .method("boot", Object.class)
                    .run((Object) null);
        } catch (Exception e) {
            e.printStackTrace();
        }

        try {
            scriptsLoader.module("/routes.golo")
                    .method("routes", Object.class)
                    .run((Object) null);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }



}
