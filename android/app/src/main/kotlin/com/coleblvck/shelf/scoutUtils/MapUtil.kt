package com.coleblvck.shelf.scoutUtils

import android.content.pm.ApplicationInfo
import android.content.pm.PackageInfo
import android.content.pm.PackageManager
import android.os.Build.VERSION.SDK_INT
import android.os.Build.VERSION_CODES.P
import androidx.annotation.RequiresApi
import java.io.File

class MapUtil {
    companion object {
        @RequiresApi(P)
        fun convertAppToMap(
            packageManager: PackageManager,
            app: ApplicationInfo,
            includeAppIcon: Boolean,
        ): HashMap<String, Any?> {
            val map = HashMap<String, Any?>()
            map["name"] = packageManager.getApplicationLabel(app)
            map["package_name"] = app.packageName
            map["icon"] =
                if (includeAppIcon) DrawableUtil.drawableToByteArray(app.loadIcon(packageManager))
                else ByteArray(0)
            val packageInfo = packageManager.getPackageInfo(app.packageName, 0)
            map["version_name"] = packageInfo.versionName
            map["version_code"] = getVersionCode(packageInfo)
            map["installed_timestamp"] = File(packageInfo.applicationInfo.sourceDir).lastModified()
            return map

        }


        @RequiresApi(P)
        @Suppress("DEPRECATION")
        private fun getVersionCode(packageInfo: PackageInfo): Long {
            return if (SDK_INT < P) packageInfo.versionCode.toLong()
            else packageInfo.longVersionCode
        }
    }
}