package com.example.flutter_app;

import android.annotation.SuppressLint;
import android.content.Intent;
import android.os.Bundle;
import android.text.TextUtils;
import android.util.Log;

import com.example.flutter_app.invoke.Iivoke;
import com.example.flutter_app.invoke.InvokeFactory;

import java.util.ArrayList;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.reactivex.Observable;
import io.reactivex.ObservableEmitter;
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.disposables.Disposable;
import io.reactivex.schedulers.Schedulers;

public class MainActivity extends FlutterActivity {

    final ArrayList<Disposable> disposables = new ArrayList<>();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        CommonUtils.log(getIntent().getDataString());
        AndroidToFlutterPlugins.registerWith(this);
        GeneratedPluginRegistrant.registerWith(this);
        new MethodChannel(getFlutterView(), InvokeFactory.CHANNEL).setMethodCallHandler(this::onMethodCall);
        checkIntent();
    }

    @Override
    protected void onNewIntent(Intent intent) {
        super.onNewIntent(intent);
        checkIntent();
    }

    private void checkIntent() {
        if (!TextUtils.isEmpty(getIntent().getDataString())) {
            AndroidToFlutterPlugins.getInstance().send(AndroidToFlutterPlugins.CLASS_FILE + getIntent().getDataString());
        }
    }

    @SuppressLint("CheckResult")
    private void onMethodCall(MethodCall call, MethodChannel.Result result) {
        Disposable disposable = Observable.create(
                (ObservableEmitter<Iivoke.Ans> emitter) -> {
                    Log.e("FlutterActivity", "ObservableEmitter"
                            + Thread.currentThread().getName()
                            + Thread.currentThread().getId());
                    emitter.onNext(InvokeFactory.onMethodCall(MainActivity.this, call));
                    emitter.onComplete();
                })
                .observeOn(AndroidSchedulers.mainThread())
                .subscribeOn(Schedulers.io())
                .subscribe(o -> {
                    switch (o.code) {
                        case -1:
                            result.notImplemented();
                            break;
                        case 0:
                            result.error("", "", "");
                            break;
                        case 1:
                            result.success(o.data);
                    }
                });
        disposables.add(disposable);
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        for (Disposable disposable : disposables) {
            disposable.isDisposed();
        }
    }
}
