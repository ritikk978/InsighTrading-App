package com.trading.insigh

import android.os.Bundle
import android.graphics.Color

import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
     override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        window.setStatusBarColor(Color.TRANSPARENT);
        window.setNavigationBarColor(Color.parseColor("#141518"));
    }
}
