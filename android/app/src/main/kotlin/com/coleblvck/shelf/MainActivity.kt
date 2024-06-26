package com.coleblvck.shelf

import android.annotation.SuppressLint
import android.content.Context
import android.content.Intent
import android.content.Intent.FLAG_ACTIVITY_NEW_TASK
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.provider.Settings.ACTION_APPLICATION_DETAILS_SETTINGS
import androidx.annotation.RequiresApi
import com.coleblvck.shelf.scoutUtils.DrawableUtil
import com.coleblvck.shelf.scoutUtils.listener.DeviceAppsChangedListener
import com.coleblvck.shelf.scoutUtils.listener.DeviceAppsChangedListenerInterface
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.android.FlutterActivityLaunchConfigs.BackgroundMode.transparent
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.EventSink
import io.flutter.plugin.common.MethodChannel
import java.lang.reflect.Method


class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        intent.putExtra("background_mode", transparent.toString())
        super.onCreate(savedInstanceState)
        appContext = this
    }

    private val shelfChannel = "shelfChannel"
    private val scoutChannel = "appScoutChannel"
    private val scoutUpdateChannel = "scoutUpdateChannel"

    @RequiresApi(Build.VERSION_CODES.TIRAMISU)
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger, shelfChannel
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "expandStatusBar" -> {
                    expandStatusBar()
                    result.success("Status Bar Expansion success!")

                }

                else -> {
                    result.notImplemented()
                }
            }
        }

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger, scoutChannel
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
        EventChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            scoutUpdateChannel
        ).setStreamHandler(
            UpdateHandler
        )
    }

    companion object {

        lateinit var appContext: Context

    }


    object UpdateHandler : EventChannel.StreamHandler, DeviceAppsChangedListenerInterface {
        private var appsChangeListener: DeviceAppsChangedListener? = null
        override fun onListen(arguments: Any?, events: EventSink?) {

            if (appsChangeListener == null) {
                appsChangeListener = DeviceAppsChangedListener(this)
            }

            appsChangeListener!!.register(appContext, events!!)

        }

        override fun onCancel(arguments: Any?) {
            appsChangeListener?.unregister(appContext)
        }

        override fun onPackageInstalled(packageName: String?, events: EventSink?) {
            events?.success("$packageName has been installed")
        }

        override fun onPackageUpdated(packageName: String?, events: EventSink?) {
            events?.success("$packageName has been updated")
        }

        override fun onPackageUninstalled(packageName: String?, events: EventSink?) {
            events?.success("$packageName has been uninstalled")
        }

        override fun onPackageChanged(packageName: String?, events: EventSink?) {
            events?.success("$packageName has been changed")
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
        val mainIntent = Intent(Intent.ACTION_MAIN, null)
        mainIntent.addCategory(Intent.CATEGORY_LAUNCHER)
        val allAppsList = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            packageManager.queryIntentActivities(
                mainIntent,
                PackageManager.ResolveInfoFlags.of(0L)
            )
        } else {
            packageManager.queryIntentActivities(
               mainIntent, 0
            )
        }
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
