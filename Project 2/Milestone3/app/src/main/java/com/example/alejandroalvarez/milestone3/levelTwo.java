package com.example.alejandroalvarez.milestone3;

import android.content.Intent;
import android.media.MediaPlayer;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.GestureDetector;
import android.view.MotionEvent;
import android.view.ScaleGestureDetector;
import android.view.View;
import android.view.animation.AlphaAnimation;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.TextView;

import java.util.ArrayList;

/**
 * Created by alejandroalvarez on 5/3/18.
 */

public class levelTwo extends AppCompatActivity {
    private GestureDetector mGestureDetector;
    private ImageView cKey,dKey,eKey,fKey,gKey,aKey,bKey,cSharpKey,dSharpKey,fSharpKey,gSharpKey,aSharpKey;
    private RelativeLayout wholeScreen;
    private ScaleGestureDetector mScaleDetector;
    private MediaPlayer cNote,dNote,eNote,fNote,gNote,aNote,bNote,cSharpNote,dSharpNote,fSharpNote,gSharpNote,aSharpNote,leveltwo;

    private Button gameButton;

    Boolean beginGame = false;
    long startTime = 0;
    long score = 0;
    int numberOfHits = 0;

    ArrayList<newHitPianoKey> hitPianoTimes = new ArrayList<levelTwo.newHitPianoKey>();
    ArrayList<levelTwo.newPianoKey> pianoTimes = new ArrayList<levelTwo.newPianoKey>();

    public class newPianoKey{
        protected String key;
        protected Boolean hit;
        protected long time;

        private newPianoKey(String newKey, Boolean newHit, long newTime){
            key = newKey;
            hit = newHit;
            time = newTime;
        }
    }

    public class newHitPianoKey{
        protected String hitKey;
        protected long hitTime;

        private newHitPianoKey(String newKey, long newTime){
            hitKey = newKey;
            hitTime = newTime;
        }
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_piano);

        System.out.println("Level Two");
        mGestureDetector = new GestureDetector(this, new levelTwo.CustomGestureDetector());
        mScaleDetector = new ScaleGestureDetector(this, new levelTwo.CustomScaleListener());

        pianoTimes.add(new levelTwo.newPianoKey("cKey",false, 1000));
        pianoTimes.add(new levelTwo.newPianoKey("dKey",false, 2000));
        pianoTimes.add(new levelTwo.newPianoKey("cKey",false, 3000));
        pianoTimes.add(new levelTwo.newPianoKey("cKey",false, 4000));
        pianoTimes.add(new levelTwo.newPianoKey("dKey",false, 5000));

        cKey = (ImageView)findViewById(R.id.cKey);
        dKey = (ImageView)findViewById(R.id.dKey);
        eKey = (ImageView)findViewById(R.id.eKey);
        fKey = (ImageView)findViewById(R.id.fKey);
        gKey = (ImageView)findViewById(R.id.gKey);
        aKey = (ImageView)findViewById(R.id.aKey);
        bKey = (ImageView)findViewById(R.id.bKey);
        cSharpKey = (ImageView)findViewById(R.id.cSharpKey);
        dSharpKey = (ImageView)findViewById(R.id.dSharpKey);
        fSharpKey = (ImageView)findViewById(R.id.fSharpKey);
        gSharpKey = (ImageView)findViewById(R.id.gSharpKey);
        aSharpKey = (ImageView)findViewById(R.id.aSharpKey);
        gameButton = (Button)findViewById(R.id.button2);
        RelativeLayout wholeScreen =(RelativeLayout)findViewById(R.id.wholeScreen);

        leveltwo = MediaPlayer.create(this, R.raw.leveltwo);
        cNote = MediaPlayer.create(this, R.raw.pianoc);
        dNote = MediaPlayer.create(this, R.raw.pianod);
        eNote = MediaPlayer.create(this, R.raw.pianoe);
        fNote = MediaPlayer.create(this, R.raw.pianof);
        gNote = MediaPlayer.create(this, R.raw.pianog);
        aNote = MediaPlayer.create(this, R.raw.pianoa);
        bNote = MediaPlayer.create(this, R.raw.pianob);
        cSharpNote = MediaPlayer.create(this, R.raw.pianocsharp);
        dSharpNote = MediaPlayer.create(this, R.raw.pianodsharp);
        fSharpNote = MediaPlayer.create(this, R.raw.pianofsharp);
        gSharpNote = MediaPlayer.create(this, R.raw.pianogsharp);
        aSharpNote = MediaPlayer.create(this, R.raw.pianoasharp);
        TextView numberLevelView;
        numberLevelView = (TextView)findViewById(R.id.numberLevel);
        numberLevelView.setText("2");

        final View.OnTouchListener onTouchListener = new View.OnTouchListener() {
            @Override
            public boolean onTouch(View v, MotionEvent event) {
                mGestureDetector.onTouchEvent(event);
                mScaleDetector.onTouchEvent(event);
                return true;
            }
        };

        wholeScreen.setOnTouchListener(onTouchListener);
    }

    public void showPopUp(View view) {
        int numberStars;

        if(score >5000){
            numberStars = 3;
        }
        else if(score >3000){
            numberStars = 2;
        }
        else if(score >1000){
            numberStars = 1;
        }
        else{
            numberStars = 0;
        }

        Intent popUpIntent = new Intent(this, LevelPopUpActivity.class);

        //pass data
        popUpIntent.putExtra("stars",Integer.toString(numberStars));
        popUpIntent.putExtra("scoreObject", Long.toString(score));
        popUpIntent.putExtra("levelName","levelTwo" );
        popUpIntent.putExtra("nextLevel","levelThree" );

        //System.out.println("Showed Pop Up");
        startActivity(popUpIntent);
    }


    public void cSharpPlay(View view) {
        opacityAnimationStart(cSharpKey);
        cSharpNote.start();
        if(beginGame) {
            long nextTime = System.currentTimeMillis();
            long scoreTime = nextTime - startTime;
            hitPianoTimes.add(new levelTwo.newHitPianoKey("cSharpKey", scoreTime));
            numberOfHits++;
        }
    }

    public void dSharpPlay(View view) {
        opacityAnimationStart(dSharpKey);
        dSharpNote.start();
        if(beginGame) {
            long nextTime = System.currentTimeMillis();
            long scoreTime = nextTime - startTime;
            hitPianoTimes.add(new levelTwo.newHitPianoKey("dSharpKey", scoreTime));
            numberOfHits++;
        }
    }

    public void fSharpPlay(View view) {
        opacityAnimationStart(fSharpKey);
        fSharpNote.start();
        if(beginGame) {
            long nextTime = System.currentTimeMillis();
            long scoreTime = nextTime - startTime;
            hitPianoTimes.add(new levelTwo.newHitPianoKey("fSharpKey", scoreTime));
            numberOfHits++;
        }
    }

    public void gSharpPlay(View view) {
        opacityAnimationStart(gSharpKey);
        gSharpNote.start();
        if(beginGame) {
            long nextTime = System.currentTimeMillis();
            long scoreTime = nextTime - startTime;
            hitPianoTimes.add(new levelTwo.newHitPianoKey("gSharpKey", scoreTime));
            numberOfHits++;
        }
    }

    public void aSharpPlay(View view) {
        opacityAnimationStart(aSharpKey);
        aSharpNote.start();
        if(beginGame) {
            long nextTime = System.currentTimeMillis();
            long scoreTime = nextTime - startTime;
            hitPianoTimes.add(new levelTwo.newHitPianoKey("aSharpKey", scoreTime));
            numberOfHits++;
        }
    }

    public void cPlay(View view) {
        opacityAnimationStart(cKey);
        cNote.start();
        long nextTime = System.currentTimeMillis();
        long scoreTime = nextTime - startTime;
        if(beginGame) {
            System.out.println("C played:" + scoreTime);
            hitPianoTimes.add(new levelTwo.newHitPianoKey("cKey", scoreTime));
            System.out.println(hitPianoTimes.get(numberOfHits));
            numberOfHits++;
        }

    }

    public void dPlay(View view) {
        opacityAnimationStart(dKey);
        dNote.start();
        if(beginGame) {
            long nextTime = System.currentTimeMillis();
            long scoreTime = nextTime - startTime;
            hitPianoTimes.add(new levelTwo.newHitPianoKey("dKey", scoreTime));
            numberOfHits++;
        }
    }

    public void ePlay(View view) {
        opacityAnimationStart(eKey);
        eNote.start();
        if(beginGame) {
            long nextTime = System.currentTimeMillis();
            long scoreTime = nextTime - startTime;
            hitPianoTimes.add(new levelTwo.newHitPianoKey("eKey", scoreTime));
            numberOfHits++;
        }
    }

    public void fPlay(View view) {
        opacityAnimationStart(fKey);
        fNote.start();
        if(beginGame) {
            long nextTime = System.currentTimeMillis();
            long scoreTime = nextTime - startTime;
            hitPianoTimes.add(new levelTwo.newHitPianoKey("fKey", scoreTime));
            numberOfHits++;
        }
    }

    public void gPlay(View view) {
        opacityAnimationStart(gKey);
        gNote.start();
        if(beginGame) {
            long nextTime = System.currentTimeMillis();
            long scoreTime = nextTime - startTime;
            hitPianoTimes.add(new levelTwo.newHitPianoKey("gKey", scoreTime));
            numberOfHits++;
        }
    }

    public void aPlay(View view) {
        opacityAnimationStart(aKey);
        aNote.start();
        if(beginGame) {
            long nextTime = System.currentTimeMillis();
            long scoreTime = nextTime - startTime;
            hitPianoTimes.add(new levelTwo.newHitPianoKey("aKey", scoreTime));
            numberOfHits++;
        }
    }

    public void bPlay(View view) {
        opacityAnimationStart(bKey);
        bNote.start();
        if (beginGame) {
            long nextTime = System.currentTimeMillis();
            long scoreTime = nextTime - startTime;
            hitPianoTimes.add(new levelTwo.newHitPianoKey("bKey", scoreTime));
            numberOfHits++;
        }
    }

    public void playbackNotes(View view) {
        leveltwo.start();
    }

    public void opacityAnimationStart(ImageView key){
        AlphaAnimation animation = new AlphaAnimation(0.5f, 1.0f);
        animation.setDuration(200);
        animation.setFillAfter(true);
        key.startAnimation(animation);
    }

    public void recordScore(View view){
        //int hitPianoLength = hitPianoTimes.size();
        //int pianoLength = pianoTimes.size();
        for (int i=0; i<hitPianoTimes.size(); i++){
            levelTwo.newHitPianoKey newHitPianoTimes = hitPianoTimes.get(i);
            for(int x=0; x<pianoTimes.size(); x++){
                levelTwo.newPianoKey newPianoTimes = pianoTimes.get(x);
                //System.out.println("Hits: " + hitPianoTimes.get(i) + "vs. Times: " + pianoTimes.get(x));
                long pianoValue = newPianoTimes.time;
                if(!newPianoTimes.hit) {
                    if (newHitPianoTimes.hitTime == pianoValue) {
                        if(newHitPianoTimes.hitKey.equals(pianoTimes.get(x).key)) {
                            System.out.println("Exact Hit");
                            score = (score + 2000);
                            newPianoTimes.hit = true;
                            System.out.println("Score: " + score);
                        }
                        else{
                            newPianoTimes.hit = true;
                            score = score + 1000;
                        }
                    }
                    else if (newHitPianoTimes.hitTime >= newPianoTimes.time - 500 && newHitPianoTimes.hitTime <= newPianoTimes.time + 500) {
                        if(newHitPianoTimes.hitKey.equals(pianoTimes.get(x).key)) {
                            System.out.println("Near Hit");
                            long otherScore = (Math.abs(newPianoTimes.time - newHitPianoTimes.hitTime));
                            otherScore = 1000 - otherScore;
                            score = (score + otherScore);
                            newPianoTimes.hit = true;
                            System.out.println("Score: " + score);
                        }
                        else{
                            newPianoTimes.hit = true;
                            long otherScore = (Math.abs(newPianoTimes.time - newHitPianoTimes.hitTime));
                            otherScore = 700 - otherScore;
                            score = score + otherScore;
                        }
                    }
                    else {
                        //System.out.println("Off Hit");
                        score = score + 0;
                    }
                }
                else {
                    System.out.println("No score: should be added: " + score);
                }
            }
        }
        if(numberOfHits == 5){
            score = score + 1000;
        }
        else if(numberOfHits > 5){
            score = score - (numberOfHits*100);
        }
        else if(numberOfHits < 5){
            score = score - 500;
        }
        else{
            score=score +0;
        }
        if(score < 0){
            score = 0;
        }
        //System.out.println("Level Over");
        showPopUp(view);
    }

    public void findStartTime(View view) {
        startTime = System.currentTimeMillis();
        if(beginGame){
            recordScore(view);
            gameButton.setText(getString(R.string.startButton));
            beginGame = false;
        }
        else{
            gameButton.setText(getString(R.string.stopButton));
            beginGame = true;
        }
    }

    class CustomGestureDetector extends GestureDetector.SimpleOnGestureListener{
        @Override
        public boolean onSingleTapConfirmed(MotionEvent e) {
            //changeText.setText("You have just used the single press gesture.");
            return false;
        }

        @Override
        public void onLongPress(MotionEvent e) {
            //changeText.setText("You have just used the long press gesture.");
        }

        @Override
        public boolean onFling(MotionEvent e1, MotionEvent e2, float velocityX, float velocityY) {
            //changeText.setText("You have just used the on fling gesture.");
            return false;
        }

        @Override
        public boolean onDoubleTap(MotionEvent e){
            Log.d("yes",Long.toString(System.currentTimeMillis()));
            return false;
        }
    }

    class CustomScaleListener extends ScaleGestureDetector.SimpleOnScaleGestureListener {

        @Override
        public boolean onScale(ScaleGestureDetector detector) {
            //changeText.setText("You have just used the on scale gesture.");
            return true;
        }

        @Override
        public boolean onScaleBegin(ScaleGestureDetector detector) {
            return true;
        }

        @Override
        public void onScaleEnd(ScaleGestureDetector detector) {
            super.onScaleEnd(detector);
        }

    }
}
