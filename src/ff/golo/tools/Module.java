package ff.golo.tools;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

/*
 User: k33g_org
 Date: 24/06/13
 Time: 08:28
*/
public class Module {
    private Class<?> module = null;
    private Method method = null;

    public Module method(String methodName, Class<?>... parametersTypes) throws NoSuchMethodException {
        this.method = this.module.getMethod(methodName, parametersTypes);
        return this;
    }

    public Object run(Object... params) throws InvocationTargetException, IllegalAccessException {
        return this.method.invoke(null, params);
    }

    public Module(Class<?> module) {
        this.module = module;
    }
}
