package ff.golo.tools;

import fr.insalyon.citi.golo.compiler.GoloClassLoader;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;

/*
 User: k33g_org
 Date: 24/06/13
 Time: 08:27
*/
public class ScriptsLoader {
    public HashMap<String,Class<?>> modules;

    private String pathToParse = null;
    private String extension = ".golo";
    private GoloClassLoader classLoader = new GoloClassLoader();

    private void findGoloScripts(String path) throws IOException {

        File root = new File( path );

        File[] list = root.listFiles(); //filter how to ?

        for ( File f : list ) {
            if ( f.isDirectory() ) {
                findGoloScripts(f.getAbsolutePath());
            }
            else {
                if(f.getAbsoluteFile().getName().endsWith(this.extension) && !f.getName().startsWith("ext.")) {

                    System.out.println( "Loading : " + f.getAbsoluteFile() );

                    Class<?> module = classLoader.load(
                            f.getName(),
                            new FileInputStream(f.getAbsoluteFile())
                    );

                    this.modules.put(f.getAbsoluteFile().toString().replaceAll("\\\\", "/").split(this.pathToParse.replaceAll("\\\\", "/"))[1], module);
                }
            }
        }

    }


    public Module module(String modulePathName) {
        return new Module(this.modules.get(modulePathName));
    }

    public void loadGoloResource(String resourcePath, String goloScript) {
        InputStream is = ClassLoader.getSystemResourceAsStream(resourcePath+goloScript);
        Class<?> module = classLoader.load(
                goloScript,
                is
        );

        System.out.println("###");

        this.modules.put(goloScript, module);
    }

    public void loadAll() {
        try {
            this.findGoloScripts(this.pathToParse);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


    public ScriptsLoader(String pathToParse) {
        this.modules = new HashMap<String, Class<?>>();
        this.pathToParse = pathToParse;

    }
}
