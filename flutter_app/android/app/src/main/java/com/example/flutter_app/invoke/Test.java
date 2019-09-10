package com.example.flutter_app.invoke;

import android.content.Context;

import io.flutter.plugin.common.MethodCall;

public class Test implements Iivoke {
    @Override
    public Ans getAns(Context context, MethodCall call) {
        System.out.print("time1:"+System.currentTimeMillis());
        try {
            Thread.sleep(10*1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        System.out.print("time2:"+System.currentTimeMillis());
        return new Ans("just_test");
    }
}
