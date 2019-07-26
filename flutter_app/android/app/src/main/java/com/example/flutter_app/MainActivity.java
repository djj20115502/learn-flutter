package com.example.flutter_app;

import android.annotation.SuppressLint;
import android.os.Bundle;
import android.util.Log;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.reactivex.Observable;
import io.reactivex.ObservableEmitter;
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.disposables.Disposable;
import io.reactivex.schedulers.Schedulers;
import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;
import jxl.read.biff.BiffException;

public class MainActivity extends FlutterActivity {

    final ArrayList<Disposable> disposables = new ArrayList<>();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Log.e("FlutterActivity", "onMethodCall"
                + Thread.currentThread().getName()
                + Thread.currentThread().getId());
        GeneratedPluginRegistrant.registerWith(this);

        new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(this::onMethodCall);
    }

    @SuppressLint("CheckResult")
    private void onMethodCall(MethodCall call, MethodChannel.Result result) {

        Disposable disposable = Observable.create(
                (ObservableEmitter<Ans> emitter) -> {
                    Log.e("FlutterActivity", "ObservableEmitter"
                            + Thread.currentThread().getName()
                            + Thread.currentThread().getId());
                    Ans ans = new Ans();
                    ans.code = 0;
                    switch (call.method) {
                        case JUST_TEST:
                            ans.code = 1;
                            ans.data = "just_testdddddddddd";
                            break;
                        case XLS:
                            ans.code = 1;
                            ans.data = analyzeXls(getFilesDir().getParent() + "/app_flutter/right.x1s");
                            break;
                        default:
                            ans.code = -1;

                    }
                    emitter.onNext(ans);
                    emitter.onComplete();
                })
                .observeOn(AndroidSchedulers.mainThread())
                .subscribeOn(Schedulers.io())
                .subscribe((Ans o) -> {
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

    private static final String CHANNEL = "samples.flutter.io";
    private static final String XLS = "xls";
    private static final String JUST_TEST = "just_test";

    class Ans {
        int code; //-1 没有方法 0 有方法没有 错误 1 有返回结果
        Object data;
    }

    public Map<String, List<List<String>>> analyzeXls(String fileName) {
        Map<String, List<List<String>>> map = new HashMap<>();
        List<List<String>> rows;
        List<String> columns = null;
        try {
            Workbook workbook = Workbook.getWorkbook(new File(fileName));
            Sheet[] sheets = workbook.getSheets();
            for (Sheet sheet : sheets) {
                rows = new ArrayList<>();
                String sheetName = sheet.getName();
                Log.e("FlutterActivity", "sheetName：" + sheetName);
                for (int i = 0; i < sheet.getRows(); i++) {
                    Cell[] sheetRow = sheet.getRow(i);
                    int columnNum = sheet.getColumns();
                    for (int j = 0; j < sheetRow.length; j++) {
                        if (j % columnNum == 0) {  //按行存数据
                            columns = new ArrayList<>();
                        }
                        columns.add(sheetRow[j].getContents());
                    }
                    rows.add(columns);
//                    Log.e("FlutterActivity", " " + columns);
                }
                map.put(sheetName, rows);
            }


        } catch (IOException e1) {
            e1.printStackTrace();
        } catch (BiffException e1) {
            e1.printStackTrace();
        }

        return map;
    }
}
