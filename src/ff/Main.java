package ff;

import ff.golo.tools.Resources;
import ff.golo.tools.ScriptsLoader;

import java.io.File;

import static spark.Spark.externalStaticFileLocation;
import static spark.Spark.setPort;


/*
 User: k33g_org
 Date: 24/06/13
 Time: 08:12
*/
public class Main {
    /*
        TODO :
         - resources package (with logo etc. ...)
    */

    public static void main(String[] args) throws Exception {

        //String appDirectory = "goloprez";

        String appDirectory = "app";

        //String appDirectory = "app.next";

        System.out.println(appDirectory);

        if(args.length > 0 ) {
            appDirectory = args[0];
        }

        Parameters.appDirectory = appDirectory;

        final ScriptsLoader scriptsLoader = new ScriptsLoader((new File(appDirectory)).getAbsolutePath());

        /* Load golo extensions (in jar file) */
        Resources.loadGoloExtensions(scriptsLoader);

        /* Load all external golo scripts (in app directory) */
        scriptsLoader.loadAll();

        /* manage parameters : http port etc. ...*/
        Resources.loadGoloApplicationParametersScripts(scriptsLoader);

        /*===static assets ===*/
        externalStaticFileLocation(Parameters.appPublicDirectory);
        /*===http port ===*/
        setPort(Parameters.appHttpPort);

        /* boot and routes ... terminate */
        Resources.loadAndRunBootAndRoutesGoloScripts(scriptsLoader);

        Resources.loadTerminateGoloScript(scriptsLoader);

        Runtime.getRuntime().addShutdownHook(Parameters.terminate);




    }

}
