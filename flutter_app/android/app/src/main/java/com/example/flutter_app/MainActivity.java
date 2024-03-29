package com.example.flutter_app;

import android.annotation.SuppressLint;
import android.os.Bundle;
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
        Log.e("FlutterActivity", "onMethodCall"
                + Thread.currentThread().getName()
                + Thread.currentThread().getId());
        GeneratedPluginRegistrant.registerWith(this);
        new MethodChannel(getFlutterView(), InvokeFactory.CHANNEL).setMethodCallHandler(this::onMethodCall);
    }

    @SuppressLint("CheckResult")
    private void onMethodCall(MethodCall call, MethodChannel.Result result) {
//        Iivoke.Ans o=  InvokeFactory.onMethodCall(MainActivity.this, call);
//        switch (o.code) {
//            case -1:
//                result.notImplemented();
//                break;
//            case 0:
//                result.error("", "", "");
//                break;
//            case 1:
//                result.success(o.data);
//        }
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
                .subscribe((Iivoke.Ans o) -> {
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
