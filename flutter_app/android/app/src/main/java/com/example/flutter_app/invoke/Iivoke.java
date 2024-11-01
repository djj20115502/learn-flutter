package com.example.flutter_app.invoke;

import android.content.Context;

import io.flutter.plugin.common.MethodCall;

public interface Iivoke {


    Ans getAns(Context context, MethodCall call);

    class Ans {
        public int code; //-1 没有方法 0 有方法但是有 错误 1 有返回结果
        //https://www.jianshu.com/p/f2755c301a3e data 只支持几个简单的类型
        public Object data;

        public Ans() {
            this.code = -1;
        }

        public Ans(Object o) {
            this.code = 1;
            this.data = o;
        }

        public static Ans error(String msg) {
            Ans rt = new Ans(msg);
            rt.code = 0;
            return rt;
        }
    }
}
