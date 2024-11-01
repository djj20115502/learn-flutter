package com.example.flutter_app;

import java.util.ArrayList;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.EventChannel;

public class AndroidToFlutterPlugins implements EventChannel.StreamHandler {
    private FlutterActivity activity;
    static final String channels_native_to_flutter = "com.bhm.flutter.flutternb.plugins/native_to_flutter";

    private AndroidToFlutterPlugins(FlutterActivity activity) {
        this.activity = activity;
    }

    public static void registerWith(FlutterActivity activity) {
        sInstance = new AndroidToFlutterPlugins(activity);
        //原生调用flutter
        EventChannel eventChannel = new EventChannel(activity.registrarFor(channels_native_to_flutter)
                .messenger(), channels_native_to_flutter);
        eventChannel.setStreamHandler(sInstance);
    }

    EventChannel.EventSink sink;

    @Override
    public void onListen(Object o, EventChannel.EventSink eventSink) {
        CommonUtils.log(eventSink);
        sink = eventSink;
        for (Object object : wait) {
            sink.success(object);
        }
        wait.clear();
    }

    @Override
    public void onCancel(Object o) {
        sink = null;
    }

    ArrayList<Object> wait = new ArrayList<>();

    public AndroidToFlutterPlugins send(Object word) {
        CommonUtils.log(sink, word);
        if (sink == null) {
            wait.add(word);
            return this;
        }
        sink.success(word);
        return this;
    }


    static AndroidToFlutterPlugins sInstance;

    public static AndroidToFlutterPlugins getInstance() {
        if (sInstance == null) {
            throw new IllegalStateException("必须先注册监听{call registerWith}才能用");
        }
        return sInstance;
    }

    //考虑到flutter解析json并不友好，使用编号+数据的方式来传递数据
    //拉起的是文件
    public static final String KEY_001_CLASS_FILE = "001";

}
