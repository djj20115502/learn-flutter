package com.example.flutter_app.invoke;

import android.content.Context;

import java.util.HashMap;

import io.flutter.plugin.common.MethodCall;

public class InvokeFactory {
    public static final String CHANNEL = "samples.flutter.io";
    private static final String FLAY_XLS = "xls";
    private static final String FLAY_JUST_TEST = "just_test";

    private static HashMap<String, Class<? extends Iivoke>> getFactoryMap() {
        if (factoryMap != null) {
            return factoryMap;
        }
        factoryMap = new HashMap<>();
        factoryMap.put(FLAY_XLS, ReadXml.class);
        factoryMap.put(FLAY_JUST_TEST, Test.class);
        return factoryMap;
    }

    private static HashMap<String, Class<? extends Iivoke>> factoryMap;

    public static Iivoke.Ans onMethodCall(Context context, MethodCall call) {
        Iivoke.Ans rt = new Iivoke.Ans();
        Class<? extends Iivoke> aClass = getFactoryMap().get(call.method);
        if (aClass == null) {
            return rt;
        }
        try {
            return aClass.newInstance().getAns(context, call);
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InstantiationException e) {
            e.printStackTrace();
        }
        return rt;
    }

}
