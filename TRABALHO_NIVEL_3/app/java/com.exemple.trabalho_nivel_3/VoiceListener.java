package com.example.trabalho_nivel_3;

import android.app.Activity;
import android.content.Intent;
import android.speech.RecognizerIntent;

import java.util.ArrayList;
import java.util.Locale;

public class VoiceListener {

    private static final int REQUEST_CODE_SPEECH_INPUT = 1001;
    private final Activity activity;

    public VoiceListener(Activity activity) {
        this.activity = activity;
    }

    public void startListening(int Code) {
        Intent intent = new Intent(RecognizerIntent.ACTION_RECOGNIZE_SPEECH);
        intent.putExtra(RecognizerIntent.EXTRA_LANGUAGE_MODEL, RecognizerIntent.LANGUAGE_MODEL_FREE_FORM);
        intent.putExtra(RecognizerIntent.EXTRA_LANGUAGE, Locale.getDefault());
        intent.putExtra(RecognizerIntent.EXTRA_PROMPT, "Fale agora...");
        activity.startActivityForResult(intent, Code);
    }

    public String processResult(int resultCode, Intent data) {
        if (resultCode == Activity.RESULT_OK && data != null) {
            ArrayList<String> result = data.getStringArrayListExtra(RecognizerIntent.EXTRA_RESULTS);
            if (result != null && !result.isEmpty()) {
                return result.get(0);
                // Aqui você pode lidar com o texto falado pelo usuário
            }
        }
        return"";
    }
}