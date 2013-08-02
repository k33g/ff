package ff.golo.tools;

import ff.Errors;
import ff.Parameters;
import fr.insalyon.citi.golo.compiler.GoloCompilationException;
import gololang.DynamicObject;

import java.io.File;
import java.lang.reflect.InvocationTargetException;

/**
 * Created with IntelliJ IDEA.
 * User: pcharrie
 * Date: 29/07/13
 * Time: 13:42
 * To change this template use File | Settings | File Templates.
 */
public class Resources {
    public static void loadGoloExtensions(ScriptsLoader scriptsLoader) {
        /* Load golo extensions (in jar file) */
        scriptsLoader.loadGoloResource("ff/golo/extensions/", "ext.ff.golo");
        scriptsLoader.loadGoloResource("ff/golo/extensions/", "ext.futures.golo");
        scriptsLoader.loadGoloResource("ff/golo/extensions/", "ext.strings.golo");

        scriptsLoader.loadGoloResource("ff/golo/extensions/", "ext.json.golo");
        scriptsLoader.loadGoloResource("ff/golo/extensions/", "ext.models.golo");
        scriptsLoader.loadGoloResource("ff/golo/extensions/", "ext.collections.golo");

        scriptsLoader.loadGoloResource("ff/golo/extensions/", "ext.routes.golo");
        scriptsLoader.loadGoloResource("ff/golo/extensions/", "ext.stores.golo");

        scriptsLoader.loadGoloResource("ff/golo/extensions/", "ext.plugins.golo");

    }

    public static void loadGoloApplicationParametersScripts(final ScriptsLoader scriptsLoader) throws NoSuchMethodException, InvocationTargetException, IllegalAccessException {
        DynamicObject params = null; //change to structure

        try {
            params = (DynamicObject) scriptsLoader.module("/parameters.golo")
                    .method("parameters", Object.class)
                    .run((Object) null);
        } catch (GoloCompilationException g) {
            System.out.println("ERROR IN  /parameters.golo");
            System.out.println(g.getProblems());

            Errors.pathFile = "parameters.golo";
            Errors.problems = g.getProblems();

        }   finally {

        }

        File f = new File(Parameters.appDirectory+"/"+(String)params.get("public"));
        Parameters.appPublicDirectory = f.getAbsolutePath();
        Parameters.appHttpPort = (int)params.get("http");

    }

    public static void loadAndRunBootAndRoutesGoloScripts(final ScriptsLoader scriptsLoader) throws NoSuchMethodException, InvocationTargetException, IllegalAccessException {
        try {
            scriptsLoader.module("/boot.golo")
                    .method("boot", Object.class)
                    .run((Object) null);
        } catch (GoloCompilationException g) {
            System.out.println("ERROR IN  /boot.golo");
            System.out.println(g.getProblems());

            Errors.pathFile = "boot.golo";
            Errors.problems = g.getProblems();

        }  finally {

        }

        ff.routes.Router.k = scriptsLoader;

        try {
            scriptsLoader.module("/routes.golo")
                    .method("routes", Object.class)
                    .run((Object) null);
        } catch (GoloCompilationException g) {
            System.out.println("ERROR IN  /routes.golo");
            System.out.println(g.getProblems());

            Errors.pathFile = "routes.golo";
            Errors.problems = g.getProblems();
        }   finally {

        }

    }

    public static void loadTerminateGoloScript(final ScriptsLoader scriptsLoader) {

        Parameters.terminate = new Thread() {
            public void run() {
                try {
                    scriptsLoader.module("/terminate.golo")
                            .method("terminate", Object.class)
                            .run((Object) null);
                } catch (GoloCompilationException g) {
                    System.out.println("ERROR IN  /terminate.golo");
                    System.out.println(g.getProblems());

                    Errors.pathFile = "terminate.golo";
                    Errors.problems = g.getProblems();
                }  catch (Exception e) {
                    e.printStackTrace();
                }
            }
        };



    }
}
