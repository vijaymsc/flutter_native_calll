package com.example.flutter_method_channel

import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val channelName = "example/channel"
    private lateinit var channel: MethodChannel

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        channel=MethodChannel(flutterEngine.dartExecutor.binaryMessenger,channelName)
        channel.setMethodCallHandler {
                call, result ->
            if(call.method == "getDataFromNative"){
//                val  arguments = call.arguments() as Map<String,String>?
//                val name = arguments!!["name"]
                        //result.success("this is from native")

                val batteryLevel = getBatteryLevel()

                if (batteryLevel != -1) {
                    result.success(batteryLevel)
                } else {
                    result.error("UNAVAILABLE", "Battery level not available.", null)
                }
            }else{
                result.notImplemented()
            }
        }
    }
    private fun getBatteryLevel(): Int {
        val batteryLvel: Int
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP){
            val  batteryMannager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
            batteryLvel= batteryMannager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        }else{
            val intent = ContextWrapper(applicationContext).registerReceiver(null, IntentFilter(
                Intent.ACTION_BATTERY_CHANGED))
            batteryLvel = intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL,-1) * 100 / intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
        }
        return batteryLvel
    }

}
