package com.example.alejandroalvarez.milestone3;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;

import java.io.Serializable;

/**
 * Created by alejandroalvarez on 5/3/18.
 */

public class LevelPopUpActivity extends AppCompatActivity {
    private ImageView star1, star2, star3;
    private TextView scoreView;
    private Button reset, next, home;
    private String scoreText, levelName, nextLevel, starsString;
    private Integer stars;

    public class newHitKey implements Serializable {
        protected String hitKey;
        protected long hitTime;

        private newHitKey(String newKey, long newTime){
            hitKey = newKey;
            hitTime = newTime;
        }
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_level_pop_up);

        //get intent
        Intent intent = getIntent();
        //pass data
        starsString = intent.getStringExtra("stars");
        scoreText = intent.getStringExtra("scoreObject");
        levelName = intent.getStringExtra("levelName");
        nextLevel = intent.getStringExtra("nextLevel");

        //ArrayList<LevelPopUpActivity.newHitKey> hitTimes = new ArrayList<LevelPopUpActivity.newHitKey>();
        //Bundle args = intent.getBundleExtra("BUNDLE");
        //ArrayList<LevelPopUpActivity.newHitKey> hitTimes = (ArrayList<LevelPopUpActivity.newHitKey>) intent.getSerializableExtra("ARRAYLIST");
        //System.out.println(hitTimes);

        levelName = "com.example.alejandroalvarez.milestone3." + levelName;
        nextLevel = "com.example.alejandroalvarez.milestone3." + nextLevel;
        System.out.println(levelName);
        System.out.println(nextLevel);

        /*
        DisplayMetrics dm = new DisplayMetrics();
        getWindowManager().getDefaultDisplay().getMetrics(dm);

        int width = dm.widthPixels;
        int height = dm.heightPixels;
        getWindow().setLayout((int)(width*.6),(int)(height*.5));
*/
        star1 = (ImageView)findViewById(R.id.star1);
        star2 = (ImageView)findViewById(R.id.star2);
        star3 = (ImageView)findViewById(R.id.star3);
        scoreView = (TextView)findViewById(R.id.scoreView);
        reset = (Button)findViewById(R.id.resetButton);
        next = (Button)findViewById(R.id.nextButton);
        home = (Button)findViewById(R.id.homeButton);
        scoreView.setText(scoreText);

        if(starsString.equals("3")){
            star3.setImageResource(R.drawable.star);
            star2.setImageResource(R.drawable.star);
            star1.setImageResource(R.drawable.star);
        }
        else if(starsString.equals("2")){
            star2.setImageResource(R.drawable.star);
            star1.setImageResource(R.drawable.star);
        }
        else if(starsString.equals("1")){
            star1.setImageResource(R.drawable.star);
        }
        else{
            System.out.println("0");
        }
    }

    public void goBackToLevel(View view) {
        try {
            Intent popUpIntent = new Intent(this,Class.forName(levelName));
            startActivity(popUpIntent);

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public void goBackToHome(View view) {
        Intent popUpIntent = new Intent(this, MainActivity.class);
        startActivity(popUpIntent);
    }

    public void goToNextLevel(View view) {
        try {
            Intent popUpIntent = new Intent(this,Class.forName(nextLevel));
            startActivity(popUpIntent);

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
}
