package com.example.alejandroalvarez.milestone3;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Spinner;

/**
 * Created by alejandroalvarez on 5/3/18.
 */

public class levelPicker extends AppCompatActivity {

    String level;
    Spinner spinner;
    ArrayAdapter<CharSequence> adapter;
    String nextLevel = "tutorial";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_level_picker);

        System.out.println("In Level Picker");

        spinner = (Spinner)findViewById(R.id.spinner);
        adapter = ArrayAdapter.createFromResource(this, R.array.levels, android.R.layout.simple_spinner_item);
        adapter.setDropDownViewResource(R.layout.support_simple_spinner_dropdown_item);
        spinner.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {

            @Override
            public void onItemSelected(AdapterView<?> adapterView, View view, int i, long l) {
                levelIntent(i);
            }

            @Override
            public void onNothingSelected(AdapterView<?> adapterView) {

            }
        });
    }

    public void levelIntent(int position){
        //didn't have time to create a tutorial
        if(position == 0){
            level="tutorial";
        }
        else if(position == 1){
            level="levelOne";
        }
        else if(position == 2){
            level="levelTwo";
        }
        else if(position == 3){
            level="levelThree";
        }
        else if(position == 4){
            level="levelFour";
        }
        else{
            level="tutorial";
        }

        level="com.example.alejandroalvarez.milestone3." + level;

        try {
            Intent intent = new Intent(this, Class.forName(level));
            //intent.putExtra(nextLevel,"tutorialText");
            startActivity(intent);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
}
