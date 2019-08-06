package com.example.flutter_app.invoke;

import android.content.Context;

import io.flutter.plugin.common.MethodCall;

public interface Iivoke {


    Ans getAns(Context context, MethodCall call);

    class Ans {
      public   int code; //-1 没有方法 0 有方法没有 错误 1 有返回结果
        public Object data;

        public Ans() {
            this.code = -1;
        }

        public Ans(Object o) {
            this.code = 1;
            this.data = o;
        }
    }
}
