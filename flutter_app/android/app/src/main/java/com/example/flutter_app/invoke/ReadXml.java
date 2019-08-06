package com.example.flutter_app.invoke;

import android.content.Context;
import android.util.Log;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;
import jxl.read.biff.BiffException;

public class ReadXml implements Iivoke {

    @Override
    public Ans getAns(Context context, MethodCall call) {
        return new Ans(analyzeXls(context.getFilesDir().getParent() + "/app_flutter/right.x1s"));
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
