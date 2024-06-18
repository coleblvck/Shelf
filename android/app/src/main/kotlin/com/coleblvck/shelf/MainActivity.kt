package com.coleblvck.shelf

import android.annotation.SuppressLint
import android.content.Context
import android.os.Build
import io.flutter.embedding.android.FlutterActivity
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivityLaunchConfigs.BackgroundMode.transparent
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.lang.reflect.Method

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        intent.putExtra("background_mode", transparent.toString())
        super.onCreate(savedInstanceState)
    }

    private val CHANNEL = "shelfChannel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
            if (call.method == "expandStatusBar") {
                expandStatusBar()
                result.success("Status Bar Expansion success!")
            } else {
                result.notImplemented()
            }
        }
    }

    private fun expandStatusBar() {
        val currentApiVersion = Build.VERSION.SDK_INT
        try {
            val service = getSystemService(Context.STATUS_BAR_SERVICE)
            val statusBarManager = Class.forName("android.app.StatusBarManager")

            val expandMethod: Method =
                if (currentApiVersion <= Build.VERSION_CODES.N) {
                    statusBarManager.getMethod("expand")
                } else {
                    statusBarManager.getMethod("expandNotificationsPanel")
                }
            expandMethod.invoke(service)
        } catch (_: Exception) {

        }
    }
}
