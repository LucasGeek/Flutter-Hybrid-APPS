package com.example.background_service

import android.app.NotificationManager
import android.app.Service
import android.content.Context
import android.content.Intent
import android.os.Build
import android.os.CountDownTimer
import android.os.IBinder
import android.util.Log
import androidx.core.app.NotificationCompat

class AppService: Service() {
    override fun onCreate() {
        super.onCreate()

        if (Build.VERSION.SDK_INT>=Build.VERSION_CODES.O) {

            val notificationBuilder = NotificationCompat.Builder(this,"msgs")
                    .setContentText("Notificação do serviço de segundo plano - Flutter")
                    .setContentTitle("Serviço de segundo plano")
                    .setSmallIcon(R.mipmap.ic_launcher)
                    .build()

            Log.v("OnService","OnService")

            //val manager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            //manager.notify((System.currentTimeMillis() % 10000).toInt(), notificationBuilder)

            startForeground((System.currentTimeMillis() % 10000).toInt(), notificationBuilder)

            Log.v("OnService","OnService")
        }


    }
    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        startService()

        return START_NOT_STICKY
    }

    override fun onBind(intent: Intent?): IBinder? {
        return null
    }

    fun startService() {
        object: CountDownTimer(50000, 1000) {
            override fun onTick(millisUntilFinished: Long) {
                Log.v("OnCalling","" + millisUntilFinished)

                if (millisUntilFinished < 1000) {
                    var item = 0;

                    for (item in 0..50) {
                        Log.v("OnCalling","" + item)
                        Thread.sleep(1000)

                        if(item == 50) {
                            startService()
                        }
                    }
                }
            }

            override fun onFinish() {}
        }.start()
    }
}