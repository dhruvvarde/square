package com.square.square

import com.squareup.sdk.reader.ReaderSdk
import io.flutter.app.FlutterApplication
import io.flutter.view.FlutterMain

class MainApplication : FlutterApplication() {
    override fun onCreate() {
        super.onCreate()
        ReaderSdk.initialize(this)
        FlutterMain.startInitialization(this)
    }
}