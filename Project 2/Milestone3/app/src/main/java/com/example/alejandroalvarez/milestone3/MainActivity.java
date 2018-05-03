package com.example.alejandroalvarez.milestone3;

import android.content.Intent;
import android.media.MediaPlayer;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

public class MainActivity extends AppCompatActivity {

    Button play;
    private MediaPlayer startSong;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        play = (Button)findViewById(R.id.play);

        startSong = MediaPlayer.create(this, R.raw.withoutme);
        startSong.setLooping(true);
        startSong.start();
    }

    public void play(View view) {
        startSong.stop();
        Intent intent = new Intent(this, levelPicker.class);
        startActivity(intent);
    }
}
