package com.example.trabalho_nivel_3;

import android.app.Notification;
import android.service.notification.NotificationListenerService;
import android.service.notification.StatusBarNotification;

class NotificationListener extends NotificationListenerService {
    @Override
    public void onNotificationPosted(StatusBarNotification sbn) {
        Notification notification = sbn.getNotification();
        if (notification != null && notification.extras != null) {
            String text = notification.extras.getString(Notification.EXTRA_TEXT);
            if (text != null) {
                // Chama o método LerMsg para ler o texto da notificação
                MainActivity.LerMsg(text);
            }
        }
    }
}