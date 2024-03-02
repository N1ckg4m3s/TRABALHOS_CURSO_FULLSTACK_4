package com.example.trabalho_nivel_3;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.app.AlarmManager;
import android.app.PendingIntent;
import android.bluetooth.BluetoothAdapter;
import android.content.Context;
import android.content.Intent;
import android.net.wifi.WifiManager;
import android.telephony.SmsManager;
import android.widget.Toast;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.ZoneId;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;
import java.util.regex.Matcher;
import java.util.regex.Pattern;


/** @noinspection ALL*/
public class ComandosDeVoz extends Activity {
    static WifiManager wifiManager;
    static BluetoothAdapter bluetoothAdapter = BluetoothAdapter.getDefaultAdapter();
    private final VoiceListener voiceListener;

    @SuppressLint("StaticFieldLeak")
    private static Context context;

    public ComandosDeVoz(Context context) {
        wifiManager = (WifiManager) context.getSystemService(Context.WIFI_SERVICE);
        ComandosDeVoz.context = context;
        voiceListener = new VoiceListener((Activity) context);
    }

    public void ProcessarComando(String voiceCommand) {
        switch (voiceCommand.toLowerCase()) {
            case "mensagem":
            case "enviar mensagem":
                MainActivity.LerMsg("Para qual numero é a mensagem");
                voiceListener.startListening(100);
                /*
                    100 numero pra mandar a msg
                    101 mensagem
                */
                break;
            case "alarme":
            case "definir alarme":
                MainActivity.LerMsg("Para quando?");
                voiceListener.startListening(102);
                break;
            case"ligar wifi":
            case"ligar wi-fi":
            case "ativar wifi":
            case "ativar wi-fi":
                if (wifiManager != null && !wifiManager.isWifiEnabled()){
                    MainActivity.LerMsg("Ligando Wi-fi");
                    wifiManager.setWifiEnabled(true);}
                else{
                    MainActivity.LerMsg("Wi-fi já esta ligado");
                }

                break;
            case"desligar wifi":
            case"desligar wi-fi":
            case "desativar wifi":
            case "desativar wi-fi":
                if (wifiManager != null && wifiManager.isWifiEnabled()) {
                    MainActivity.LerMsg("Desligando Wi-fi");
                    wifiManager.setWifiEnabled(false);
                }else{
                    MainActivity.LerMsg("Wi-fi já esta desligado");
                }
                break;
            case"ligar bluetooth":
            case "ativar bluetooth":
                if (bluetoothAdapter != null && !bluetoothAdapter.isEnabled()) {
                    MainActivity.LerMsg("Ligando bluetooth");
                    bluetoothAdapter.enable();
                }else{
                    MainActivity.LerMsg("bluetooth já esta ligado");
                }
                break;
            case "desligar bluetooth":
            case "desativar bluetooth":
              if (bluetoothAdapter != null && bluetoothAdapter.isEnabled()) {
                  MainActivity.LerMsg("Desligando bluetooth");
                    bluetoothAdapter.disable();
                }else{
                  MainActivity.LerMsg("bluetooth já esta desligado");
              }
                break;
            default:
                Toast.makeText(context, "Comando de voz não reconhecido.", Toast.LENGTH_SHORT).show();
                break;
        }
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        String textoFalado = voiceListener.processResult( resultCode, data);
        switch (requestCode){
            case 100:
                Map<String, String> espera = new HashMap<>();
                if(Pattern.matches("\\d{10}",textoFalado)) {
                    espera.put("Numero", textoFalado);
                    MainActivity.LerMsg("Otimo, Qual a mensagem para o numero"+textoFalado);
                    voiceListener.startListening(101);
                }else{
                    MainActivity.LerMsg("Numero invalido, tente novamente");
                    voiceListener.startListening(100);
                }
                break;
            case 101:
                MainActivity.LerMsg("Ok, Enviando mensagem");
                SmsManager smsManager = SmsManager.getDefault();
                PendingIntent sentIntent = PendingIntent.getBroadcast(context, 0, new Intent("SMS_SENT"),PendingIntent.FLAG_IMMUTABLE);
                PendingIntent deliveredIntent = PendingIntent.getBroadcast(context, 0, new Intent("SMS_DELIVERED"), PendingIntent.FLAG_IMMUTABLE);
                smsManager.sendTextMessage(textoFalado, null, textoFalado, sentIntent, deliveredIntent);
                break;
            case 102:
                long Tempo = identificarTempo(textoFalado);
                if(Tempo==0)return;
                AlarmManager alarmManager = (AlarmManager) context.getSystemService(Context.ALARM_SERVICE);
                if (alarmManager != null) {
                    alarmManager.set(AlarmManager.RTC_WAKEUP, Tempo,null);
                }
            break;
        }
    }
    long identificarTempo(String texto) {
        // Expressão regular para identificar "em X minutos"
        Pattern patternMinutos = Pattern.compile("em\\s+(\\d+)\\s+minuto(s)?");
        Matcher matcherMinutos = patternMinutos.matcher(texto);

        // Expressão regular para identificar "semana que vem"
        Pattern patternSemanaQueVem = Pattern.compile("semana que vem");
        Matcher matcherSemanaQueVem = patternSemanaQueVem.matcher(texto);

        // Expressão regular para identificar "amanhã às HH:MM"
        Pattern patternAmanha = Pattern.compile("amanhã às\\s+(\\d{2}):(\\d{2})");
        Matcher matcherAmanha = patternAmanha.matcher(texto);

        if (matcherMinutos.find()) {
            int minutos = Integer.parseInt(Objects.requireNonNull(matcherMinutos.group(1)));
            LocalDateTime tempo = LocalDateTime.now().plusMinutes(minutos);
            return tempo.atZone(ZoneId.systemDefault()).toInstant().toEpochMilli();
        } else if (matcherSemanaQueVem.find()) {
            LocalDate data = LocalDate.now().plusWeeks(1);
            LocalDateTime tempo = data.atTime(LocalTime.MIDNIGHT);
            return tempo.atZone(ZoneId.systemDefault()).toInstant().toEpochMilli();
        } else if (matcherAmanha.find()) {
            int hora = Integer.parseInt(Objects.requireNonNull(matcherAmanha.group(1)));
            int minuto = Integer.parseInt(Objects.requireNonNull(matcherAmanha.group(2)));
            LocalDate amanha = LocalDate.now().plusDays(1);
            LocalDateTime tempo = LocalDateTime.of(amanha, LocalTime.of(hora, minuto));
            return tempo.atZone(ZoneId.systemDefault()).toInstant().toEpochMilli();
        } else {
            System.out.println("Nenhum tempo identificado.");
        }
        return 0;
    }
}