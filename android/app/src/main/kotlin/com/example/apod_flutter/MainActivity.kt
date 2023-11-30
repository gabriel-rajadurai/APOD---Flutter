package com.example.apod_flutter

import io.flutter.embedding.android.FlutterActivity
import androidx.core.content.FileProvider
import java.io.File
import android.content.Intent
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodCall
import androidx.annotation.NonNull

class MainActivity: FlutterActivity() {
    private val CHANNEL = "apod.gabriel.com/openFile"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
                if(call.method == "viewFile"){
                    viewFile(call)
                    result.success(true)
                }
        }
  }

  fun viewFile(call: MethodCall){
    val filePath = call.arguments as String
    val fileUri = FileProvider.getUriForFile(this, "${applicationContext.packageName}.provider", File(filePath))
    val intent = Intent(Intent.ACTION_VIEW)
    intent.data = fileUri
    intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
    startActivity(intent)
  }
}
