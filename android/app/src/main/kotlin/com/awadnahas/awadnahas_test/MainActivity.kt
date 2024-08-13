package com.awadnahas.awadnahas_test

import android.os.Bundle
import com.microsoft.clarity.Clarity
import com.microsoft.clarity.ClarityConfig

//import io.flutter.embedding.android.FlutterActivity
//
//class MainActivity: FlutterActivity() {
//}

import io.flutter.embedding.android.FlutterFragmentActivity
class MainActivity: FlutterFragmentActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val config = ClarityConfig("netzz62j2f")
        Clarity.initialize(applicationContext, config)
    }
}