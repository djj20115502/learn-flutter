package com.example.flutter_app.invoke;

import android.content.Context;

import io.flutter.plugin.common.MethodCall;

public class Test implements Iivoke {
    @Override
    public Ans getAns(Context context, MethodCall call) {
        return new Ans("just_test");
    }
}
