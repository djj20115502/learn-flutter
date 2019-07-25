package com.example.flutter_app;

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
import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;
import jxl.read.biff.BiffException;

public class MainActivity extends FlutterActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Log.e("FlutterActivity", "onMethodCall");
        GeneratedPluginRegistrant.registerWith(this);
        new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(new MethodChannel.MethodCallHandler() {
            @Override
            public void onMethodCall(MethodCall call, MethodChannel.Result result) {
                Log.e("FlutterActivity", "onMethodCall");
                analyzeXls( getFilesDir().getParent()+"/app_flutter/test.x1s");
                if (call.method.equals("just_test")) {
                    result.success("just_testdddddddddd");
                }
            }
        });

    }

    private static final String CHANNEL = "samples.flutter.io";


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
                Log.e("FlutterActivity", "sheetName："+sheetName);
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
                    Log.e("FlutterActivity", " "+columns);
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
