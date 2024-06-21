package com.coleblvck.shelf.scoutUtils.listener

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import io.flutter.plugin.common.EventChannel.EventSink


class DeviceAppsChangedListener(private val callback: DeviceAppsChangedListenerInterface) {
    private val sinks: MutableSet<EventSink> = HashSet(1)

    private var appsBroadcastReceiver: BroadcastReceiver? = null

    fun register(context: Context, events: EventSink) {
        if (appsBroadcastReceiver == null) {
            createBroadcastReceiver()
        }

        val intentFilter = IntentFilter()
        intentFilter.addAction(Intent.ACTION_PACKAGE_ADDED)
        intentFilter.addAction(Intent.ACTION_PACKAGE_REPLACED)
        intentFilter.addAction(Intent.ACTION_PACKAGE_CHANGED)
        intentFilter.addAction(Intent.ACTION_PACKAGE_REMOVED)
        intentFilter.addDataScheme("package")

        sinks.add(events)

        context.registerReceiver(appsBroadcastReceiver, intentFilter)
    }

    private fun createBroadcastReceiver() {
        appsBroadcastReceiver = object : BroadcastReceiver() {
            override fun onReceive(context: Context, intent: Intent) {
                val packageName = intent.dataString!!.replace("package:", "")

                val replacing = intent.extras!!
                    .getBoolean(Intent.EXTRA_REPLACING, false)

                when (intent.action) {
                    Intent.ACTION_PACKAGE_ADDED -> if (!replacing) {
                        onPackageInstalled(packageName)
                    }

                    Intent.ACTION_PACKAGE_REPLACED -> onPackageUpdated(packageName)
                    Intent.ACTION_PACKAGE_CHANGED -> {
                        val components =
                            intent.extras!!.getStringArray(Intent.EXTRA_CHANGED_COMPONENT_NAME_LIST)
                        if (components!!.size == 1 && components[0].equals(
                                packageName,
                                ignoreCase = true
                            )
                        ) {
                            onPackageChanged(packageName)
                        }
                    }

                    Intent.ACTION_PACKAGE_REMOVED -> if (!replacing) {
                        onPackageUninstalled(packageName)
                    }
                }
            }
        }
    }

    fun onPackageInstalled(packageName: String?) {
        for (sink in sinks) {
            callback.onPackageInstalled(packageName, sink)
        }
    }

    fun onPackageUpdated(packageName: String?) {
        for (sink in sinks) {
            callback.onPackageUpdated(packageName, sink)
        }
    }

    fun onPackageUninstalled(packageName: String?) {
        for (sink in sinks) {
            callback.onPackageUninstalled(packageName, sink)
        }
    }

    fun onPackageChanged(packageName: String?) {
        for (sink in sinks) {
            callback.onPackageChanged(packageName, sink)
        }
    }

    fun unregister(context: Context) {
        if (appsBroadcastReceiver != null) {
            context.unregisterReceiver(appsBroadcastReceiver)
        }

        sinks.clear()
    }
}