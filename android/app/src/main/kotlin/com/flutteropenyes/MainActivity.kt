package com.flutteropenyes

import android.app.AlertDialog
import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Bundle
import android.os.PersistableBundle
import android.provider.Settings
import com.example.speed_plugin.flutter.eyepetizer.speech.plugin.SpeechManager
import com.example.speed_plugin.flutter.eyepetizer.speech.plugin.SpeechPlugin
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import org.devio.flutter.splashscreen.SplashScreen


class MainActivity: FlutterActivity() {

    var mSpeechPlugin: SpeechPlugin? = null
    override fun onCreate(savedInstanceState: Bundle?, persistentState: PersistableBundle?) {
        SplashScreen.show(this, true)
        super.onCreate(savedInstanceState, persistentState)
//        GeneratedPluginRegistrant.registerWith(flutterEngine);
        SpeechManager.getInstance().init(this)

        
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine!!)
        mSpeechPlugin = SpeechPlugin.registerWith(flutterEngine,this)
    }

    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<String>, grantResults: IntArray) {
        super.onRequestPermissionsResult(requestCode, permissions!!, grantResults)
        if (requestCode == SpeechPlugin.RECOGNIZER_REQUEST_CODE) {
            if (grantResults.size > 0) {
                var grantedSize = 0
                for (grantResult in grantResults) {
                    if (grantResult == PackageManager.PERMISSION_GRANTED) {
                        grantedSize++
                    }
                }
                if (grantedSize == grantResults.size) {
                    mSpeechPlugin!!.startRecognizer()
                } else {
                    showWaringDialog()
                }
            } else {
                showWaringDialog()
            }
        }
    }

    private fun showWaringDialog() {
        AlertDialog.Builder(this, android.R.style.Theme_Material_Light_Dialog_Alert)
                .setTitle(R.string.waring)
                .setMessage(R.string.permission_waring)
                .setPositiveButton(R.string.sure) { dialog, which -> go2AppSettings() }.setNegativeButton(R.string.cancel, null).show()
    }

    private fun go2AppSettings() {
        val intent = Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS)
        val uri = Uri.fromParts("package", packageName, null)
        intent.data = uri
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        startActivity(intent)
    }
}
