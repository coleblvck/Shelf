package com.coleblvck.shelf.scoutUtils.listener

import io.flutter.plugin.common.EventChannel.EventSink


interface DeviceAppsChangedListenerInterface {
    fun onPackageInstalled(packageName: String?, events: EventSink?)

    fun onPackageUpdated(packageName: String?, events: EventSink?)

    fun onPackageUninstalled(packageName: String?, events: EventSink?)

    fun onPackageChanged(packageName: String?, events: EventSink?)
}