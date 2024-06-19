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
import com.coleblvck.shelf.scoutUtils.MapUtil.Companion.convertAppToMap
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

    @RequiresApi(Build.VERSION_CODES.P)
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
                    val includeSystemApps = call.argument("includeSystemApps") ?: false
                    val includeAppIcons = call.argument("includeAppIcons") ?: true
                    Thread {
                        val apps: List<Map<String, Any?>> =
                            fetchApps(includeSystemApps, includeAppIcons)
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

    @RequiresApi(Build.VERSION_CODES.P)
    private fun fetchApps(
        includeSystemApps: Boolean,
        includeAppIcons: Boolean,
    ): List<Map<String, Any?>> {
        var apps = packageManager.getInstalledApplications(0)
        if (!includeSystemApps) {
            apps = apps.filter { app -> !isSystemApp(app.packageName) }
        }
        return apps.map { app -> convertAppToMap(packageManager, app, includeAppIcons) }
    }

    private fun isSystemApp(packageName: String): Boolean {
        return packageManager.getLaunchIntentForPackage(packageName) == null
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

    private fun isAppInstalled(packageName: String?): Boolean {
        return try {
            packageManager.getPackageInfo(packageName ?: "", PackageManager.GET_ACTIVITIES)
            true
        } catch (e: PackageManager.NameNotFoundException) {
            false
        }
    }
}
