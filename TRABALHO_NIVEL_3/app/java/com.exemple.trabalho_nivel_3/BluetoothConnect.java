package com.example.trabalho_nivel_3;

import android.bluetooth.BluetoothDevice;
import android.bluetooth.BluetoothProfile;
import android.content.Context;
import android.media.AudioDeviceInfo;
import android.media.AudioManager;

public class BluetoothConnect implements BluetoothProfile.ServiceListener {
    private final Context context;

    public BluetoothConnect(Context context) {
        this.context = context;
    }
    @Override
    public void onServiceConnected(int profile, BluetoothProfile proxy) {
        if (profile == BluetoothProfile.A2DP) {
            if (proxy != null) {
                for (BluetoothDevice device : proxy.getConnectedDevices()) {
                    if (device != null) {
                        AudioManager audioManager = (AudioManager) context.getSystemService(Context.AUDIO_SERVICE);
                        AudioDeviceInfo[] audioDevices = audioManager.getDevices(AudioManager.GET_DEVICES_OUTPUTS);
                        boolean isBluetoothA2dpConnected = false;
                        boolean isBuiltInSpeakerConnected = false;
                        for (AudioDeviceInfo audioDevice : audioDevices) {
                            if (audioDevice.getType() == AudioDeviceInfo.TYPE_BLUETOOTH_A2DP) {
                                isBluetoothA2dpConnected = true;
                            } else if (audioDevice.getType() == AudioDeviceInfo.TYPE_BUILTIN_SPEAKER) {
                                isBuiltInSpeakerConnected = true;
                            }
                        }
                        if (isBluetoothA2dpConnected) {
                            MainActivity.LerMsg("Bluetooth A2DP");
                        }
                        if (isBuiltInSpeakerConnected) {
                            MainActivity.LerMsg("Alto-falante integrado");
                        }
                    }
                }
            }
        }
    }

    @Override
    public void onServiceDisconnected(int profile) {

    }
}
