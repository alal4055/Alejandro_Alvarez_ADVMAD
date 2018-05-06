package com.example.alejandroalvarez.lab9;

import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.TextView;

/**
 * Created by alejandroalvarez on 5/6/18.
 */

public class WorkoutTime extends AppCompatActivity {


    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_time);

        Intent intent = getIntent();
        String workoutTime = intent.getStringExtra("time");

        TextView textView = (TextView)findViewById(R.id.textView);
        textView.setText(workoutTime);
    }

    public void goHome(View view) {
        Intent intent = new Intent(this, MainActivity.class);
        startActivity(intent);
    }
}
