package com.coleblvck.shelf

import android.annotation.SuppressLint
import android.content.Context
import android.content.Intent
import android.content.Intent.FLAG_ACTIVITY_NEW_TASK
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Build
import io.flutter.embedding.android.FlutterActivity
import android.os.Bundle
import android.provider.Settings.ACTION_APPLICATION_DETAILS_SETTINGS
import androidx.annotation.RequiresApi
import com.coleblvck.shelf.scoutUtils.DrawableUtil
import com.coleblvck.shelf.scoutUtils.MapUtil.Companion._convertAppToMap
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
    private val SCOUTCHANNEL = "appScoutChannel"

    @RequiresApi(Build.VERSION_CODES.TIRAMISU)
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger, CHANNEL
        ).setMethodCallHandler { call, result ->
            if (call.method == "expandStatusBar") {
                expandStatusBar()
                result.success("Status Bar Expansion success!")
            } else {
                result.notImplemented()
            }
        }

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger, SCOUTCHANNEL
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "fetchApps" -> {
                    Thread {
                        val apps: List<Map<String, Any?>> =
                            fetchApps()
                        result.success(apps)
                    }.start()

                }

                "launchApp" -> {
                    val packageName: String = call.argument("packageName")!!
                    result.success(launchApp(packageName))
                }

                "openAppSettings" -> {
                    val packageName: String = call.argument("packageName")!!
                    result.success(openAppSettings(packageName))
                }

                "uninstallApp" -> {
                    val packageName: String = call.argument("packageName")!!
                    result.success(uninstallApp(packageName))
                }

                else -> result.notImplemented()
            }
        }
    }

    @RequiresApi(Build.VERSION_CODES.TIRAMISU)
    @SuppressLint("WrongConstant")
    private fun expandStatusBar() {
        val currentApiVersion = Build.VERSION.SDK_INT
        try {
            val service = getSystemService(Context.STATUS_BAR_SERVICE)
            val statusBarManager = Class.forName("android.app.StatusBarManager")

            val expandMethod: Method = if (currentApiVersion <= Build.VERSION_CODES.N) {
                statusBarManager.getMethod("expand")
            } else {
                statusBarManager.getMethod("expandNotificationsPanel")
            }
            expandMethod.invoke(service)
        } catch (_: Exception) {

        }
    }


    private fun fetchApps(): List<Map<String, Any?>> {
        val packageManager = context.packageManager
        val allAppsList = packageManager.queryIntentActivities(
            Intent(
                Intent.ACTION_MAIN,
                null
            ).addCategory(Intent.CATEGORY_LAUNCHER), 0
        )
        val listToReturn = emptyList<Map<String, Any?>>().toMutableList()
        for (appInfo in allAppsList) {
            if (appInfo.activityInfo.packageName != context.packageName) {
                val appMap = HashMap<String, Any?>()
                appMap["name"] = appInfo.loadLabel(packageManager).toString()
                appMap["packageName"] = appInfo.activityInfo.packageName
                appMap["icon"] =
                    DrawableUtil.drawableToByteArray(appInfo.activityInfo.loadIcon(packageManager))
                listToReturn += appMap
            }
        }
        return listToReturn
    }

    private fun launchApp(packageName: String): Boolean {
        return try {
            val launchIntent = packageManager.getLaunchIntentForPackage(packageName)
            context.startActivity(launchIntent)
            true
        } catch (e: Exception) {
            false
        }
    }

    private fun openAppSettings(packageName: String): Boolean {
        return try {
            val intent = Intent().apply {
                flags = FLAG_ACTIVITY_NEW_TASK
                action = ACTION_APPLICATION_DETAILS_SETTINGS
                data = Uri.fromParts("package", packageName, null)
            }
            context.startActivity(intent)
            true
        } catch (e: Exception) {
            false
        }
    }

    private fun uninstallApp(packageName: String): Boolean {
        return try {
            val intent = Intent(Intent.ACTION_DELETE)
            intent.data = Uri.parse("package:$packageName")
            context.startActivity(intent)
            true
        } catch (e: Exception) {
            false
        }
    }
}
