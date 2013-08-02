package ff.routes;

import ff.Errors;
import ff.golo.tools.ScriptsLoader;
import spark.Request;
import spark.Response;
import spark.Route;

import static spark.Spark.*;
/*
 User: k33g_org
 Date: 17/07/13
 Time: 19:20
*/
public class Router {
    public static ScriptsLoader k;



    public static void GET(String route, final String script, final String method) {

        System.out.println("GET : "+route+" script : "+script+" method : "+method);

        get(new Route(route){
            @Override
            public Object handle(Request request, Response response) {

                Object ret = null;

                try {
                    ret = (Object) k.module(script)
                            .method(method, Object.class, Object.class)
                            .run(request, response);
                } catch (Exception e) {
                    response.redirect("/dev_error");
                    e.printStackTrace();
                } finally {
                    return ret;
                }

            }
        });


        get(new Route("/dev_error") {
            @Override
            public Object handle(Request request, Response response) {
                String reportError = "\n" +
                        "<h1>ERROR</h1>\n" +
                        "<h2>in "+Errors.pathFile+"</h2>\n" +
                        "<hr>\n" +
                        "<pre><code>" + Errors.problems + "</code></pre>\n" +
                        "<hr>";
                return reportError;
            }
        });

    }

    public static void POST(String route, final String script, final String method) {

        System.out.println("POST : "+route+" script : "+script+" method : "+method);

        post(new Route(route) {
            @Override
            public Object handle(Request request, Response response) {

                Object ret = null;

                try {
                    ret = (Object) k.module(script)
                            .method(method, Object.class, Object.class)
                            .run(request, response);
                } catch (Exception e) {
                    response.redirect("/dev_error");
                    e.printStackTrace();
                } finally {
                    return ret;
                }

            }
        });
    }

    public static void PUT(String route, final String script, final String method) {

        System.out.println("PUT : "+route+" script : "+script+" method : "+method);

        put(new Route(route) {
            @Override
            public Object handle(Request request, Response response) {

                Object ret = null;

                try {
                    ret = (Object) k.module(script)
                            .method(method, Object.class, Object.class)
                            .run(request, response);
                } catch (Exception e) {
                    response.redirect("/dev_error");
                    e.printStackTrace();
                } finally {
                    return ret;
                }

            }
        });
    }


    public static void DELETE(String route, final String script, final String method) {

        System.out.println("DELETE : "+route+" script : "+script+" method : "+method);

        delete(new Route(route) {
            @Override
            public Object handle(Request request, Response response) {

                Object ret = null;

                try {
                    ret = (Object) k.module(script)
                            .method(method, Object.class, Object.class)
                            .run(request, response);
                } catch (Exception e) {
                    response.redirect("/dev_error");
                    e.printStackTrace();
                } finally {
                    return ret;
                }

            }
        });
    }
}
