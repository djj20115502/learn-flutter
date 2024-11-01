package com.example.flutter_app;

import android.util.Log;

public class CommonUtils {

    public static void log(Object... objects) {

        if (objects == null) {
            return;
        }
        StringBuilder sb = new StringBuilder();
        Throwable a = new Throwable();
        StackTraceElement[] traceElement = a.getStackTrace();
        sb.append(" \n╔═════════════════════════════════");
        sb.append("\n║➨➨at ");
        sb.append(traceElement[1]);
        sb.append("\n║➨➨➨➨at ");
        sb.append(traceElement[2]);
        sb.append("\n╟───────────────────────────────────\n");
        sb.append("║");
        for (Object o : objects) {
            if (o != null) {
                sb.append(o.toString());
            } else {
                sb.append("null");
            }
            sb.append("___");
        }
        sb.append("\n╚═════════════════════════════════");
        Log.e("djjtest", sb.toString());
    }
}
