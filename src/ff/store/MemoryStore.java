package ff.store;

/*
 User: k33g_org
 Date: 17/07/13
 Time: 19:26
*/
import java.util.HashMap;

public class MemoryStore {

    private static HashMap<String,Object> memory = new HashMap<>();

    public static void set(String key, Object objectToStore) {
        memory.put(key, objectToStore);
    }

    public static Object get(String key) {
        return memory.get(key);
    }

    public static void delete(String key) {
        memory.remove(key);
    }

    public static HashMap<String, Object> getMemory() {
        return memory;
    }

    public static void setMemory(HashMap<String, Object> memory) {
        MemoryStore.memory = memory;
    }
}
