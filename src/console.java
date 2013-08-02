/*
 User: k33g_org
 Date: 18/07/13
 Time: 19:47
*/
public class console {
    static public String buffer = "";
    static  public String buffer() {
        return buffer;
    }
    static  public void empty() {
        buffer ="";
    }
    static public void  log(Object p) {
        //System.out.println(p);
        buffer+=p.toString()+"\n";

    }
}
