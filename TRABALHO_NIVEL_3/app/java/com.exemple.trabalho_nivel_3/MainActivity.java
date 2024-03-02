package com.example.trabalho_nivel_3;

import android.app.Activity;
import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothProfile;
import android.content.Intent;
import android.os.Bundle;
import android.os.VibrationEffect;
import android.os.Vibrator;
import android.speech.RecognizerIntent;
import android.speech.tts.TextToSpeech;
import android.widget.Button;

import java.util.ArrayList;
import java.util.Locale;

public class MainActivity extends Activity {
    ComandosDeVoz ComandosDeVoz;
    private static boolean PodeFalar=true;
    private static TextToSpeech TextoFalar;
    private static Vibrator vibrator;

    public MainActivity() {}

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        Button BurLerMag = findViewById(R.id.butLerMag);
        BurLerMag.setOnClickListener(v -> {
            PodeFalar=!PodeFalar;
            LerMsg("Permissão de fala modificada");
            if(PodeFalar){
                BurLerMag.setBackgroundColor(0xFF4285F4);
            }else{
                BurLerMag.setBackgroundColor(0xFF333333);
            }
        });

        Button butCmdVoz = findViewById(R.id.butCmdVoz);
        butCmdVoz.setOnClickListener(v -> FalarTexto());

        vibrator= (Vibrator) getSystemService(VIBRATOR_SERVICE);

        TextoFalar = new TextToSpeech(getApplicationContext(), status -> {
            if (status != TextToSpeech.ERROR) {
                TextoFalar.setLanguage(Locale.getDefault());
            }
        });
        LerMsg("Iniciar app");
        ComandosDeVoz = new ComandosDeVoz(this);
        BluetoothAdapter bluetoothAdapter = BluetoothAdapter.getDefaultAdapter();
        bluetoothAdapter.getProfileProxy(this, new BluetoothConnect(this), BluetoothProfile.A2DP);
    }

    static void LerMsg(String Msg) {
        if(PodeFalar && TextoFalar != null){
            TextoFalar.speak(Msg, TextToSpeech.QUEUE_FLUSH, null, null);
        }else{
            vibrator.vibrate(VibrationEffect.createOneShot(50, VibrationEffect.DEFAULT_AMPLITUDE));
        }
    }

    private void FalarTexto() {
        Intent intent = new Intent(RecognizerIntent.ACTION_RECOGNIZE_SPEECH);
        intent.putExtra(RecognizerIntent.EXTRA_LANGUAGE_MODEL, RecognizerIntent.LANGUAGE_MODEL_FREE_FORM);
        intent.putExtra(RecognizerIntent.EXTRA_LANGUAGE, Locale.getDefault());
        intent.putExtra(RecognizerIntent.EXTRA_PROMPT, "Fale agora...");
        startActivityForResult(intent, 1001);
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        // Libere os recursos do TextToSpeech
        if (TextoFalar != null) {
            TextoFalar.stop();
            TextoFalar.shutdown();
        }
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == 1001) {
            if (resultCode == RESULT_OK && null != data) {
                ArrayList<String> result = data.getStringArrayListExtra(RecognizerIntent.EXTRA_RESULTS);
                assert result != null;
                String spokenText = result.get(0);
                ComandosDeVoz.ProcessarComando(spokenText);
                // Implemente a lógica para processar o comando de voz aqui
            }
        }
    }
}
