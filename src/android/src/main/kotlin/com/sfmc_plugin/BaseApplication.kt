package com.sfmc_plugin

import android.app.Application
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.util.Log
import com.salesforce.marketingcloud.MCLogListener
import com.salesforce.marketingcloud.MarketingCloudConfig
import com.salesforce.marketingcloud.MarketingCloudSdk
import com.salesforce.marketingcloud.UrlHandler
import com.salesforce.marketingcloud.messages.iam.InAppMessage
import com.salesforce.marketingcloud.messages.iam.InAppMessageManager
import com.salesforce.marketingcloud.notifications.NotificationCustomizationOptions
import com.salesforce.marketingcloud.notifications.NotificationManager
import com.salesforce.marketingcloud.sfmcsdk.*
import io.flutter.app.FlutterApplication
import java.util.*

const val LOG_TAG = "MCSDK"

abstract class BaseApplication : FlutterApplication(), UrlHandler {
    open val configBuilder: MarketingCloudConfig.Builder
        get() = MarketingCloudConfig.builder().apply {
           setApplicationId(BuildConfig.MC_APP_ID)
           setAccessToken(BuildConfig.MC_ACCESS_TOKEN)
           setSenderId(BuildConfig.MC_SENDER_ID)
           setMid(BuildConfig.MC_MID)
           setMarketingCloudServerUrl(BuildConfig.MC_SERVER_URL)
           setDelayRegistrationUntilContactKeyIsSet(true)
           setAnalyticsEnabled(true)
           setUrlHandler(this@BaseApplication)
           setNotificationCustomizationOptions(
               NotificationCustomizationOptions.create { context, notificationMessage ->
                   val builder = NotificationManager.getDefaultNotificationBuilder(
                       context,
                       notificationMessage,
                       NotificationManager.createDefaultNotificationChannel(context),
                       R.drawable.ic_notification
                   )
                   builder.setContentIntent(
                       NotificationManager.redirectIntentForAnalytics(
                           context,
                           PendingIntent.getActivity(
                               context,
                               Random().nextInt(),
                               Intent(Intent.ACTION_VIEW, Uri.parse(notificationMessage.url)),
                               PendingIntent.FLAG_IMMUTABLE
                           ),
                           notificationMessage,
                           true,
                       )
                   )
               }
           )
       }

    override fun onCreate() {
        super.onCreate()
        initSDK()
    }

    override fun handleUrl(context: Context, url: String, urlSource: String): PendingIntent? {
        return PendingIntent.getActivity(
            context,
            1,
            Intent(Intent.ACTION_VIEW, Uri.parse(url)),
            PendingIntent.FLAG_IMMUTABLE
        )
    }

    private fun initSDK() {
        if (BuildConfig.DEBUG) {
            MarketingCloudSdk.setLogLevel(MCLogListener.VERBOSE)
            MarketingCloudSdk.setLogListener(MCLogListener.AndroidLogListener())
        }

        SFMCSdk.configure(applicationContext as Application, SFMCSdkModuleConfig.build {
            pushModuleConfig = configBuilder.build(applicationContext)
        }) { initStatus ->

            when (initStatus.status) {
                InitializationStatus.SUCCESS -> {
                    Log.v(LOG_TAG, "Marketing Cloud initialization successful.")
                }
                InitializationStatus.FAILURE -> {
                    // Given that this app is used to show SDK functionality we will hard exit if SDK init outright failed.
                    Log.e(
                        LOG_TAG,
                        "Marketing Cloud initialization failed. "
                    )
                    throw RuntimeException("Init failed")
                }
            }
        }

        SFMCSdk.requestSdk { sdk ->
            sdk.mp {
                it.inAppMessageManager.run {
                    setInAppMessageListener(object : InAppMessageManager.EventListener {
                        override fun shouldShowMessage(message: InAppMessage): Boolean {
                            // This method will be called before an in app message is presented.  You can return `false` to
                            // prevent the message from being displayed.  You can later use call `InAppMessageManager#showMessage`
                            // to display the message if the message is still on the device and active.
                            return true
                        }

                        override fun didShowMessage(message: InAppMessage) {
                            Log.v(LOG_TAG, "${message.id} was displayed.")
                        }

                        override fun didCloseMessage(message: InAppMessage) {
                            Log.v(LOG_TAG, "${message.id} was closed.")
                        }
                    })
                }
            }
        }
    }
}
