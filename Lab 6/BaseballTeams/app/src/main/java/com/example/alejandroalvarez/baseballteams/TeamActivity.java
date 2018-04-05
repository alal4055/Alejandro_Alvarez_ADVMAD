package com.example.alejandroalvarez.baseballteams;

import android.app.Activity;
import android.media.Image;
import android.os.Bundle;
import android.view.MenuItem;
import android.widget.ImageView;
import android.widget.TextView;
import android.view.Menu;
import android.content.Intent;

public class TeamActivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_team);

        //get bulb id from the intent
        int teamnum = (Integer)getIntent().getExtras().get("teamid");
        String teamtype = getIntent().getStringExtra("teamtype");
        Team team = Team.rockies[teamnum];
       if(teamtype.equals("Rockies")) {
           team = Team.rockies[teamnum];
       }
       else if(teamtype.equals("Dodgers")){
           team = Team.dodgers[teamnum];
       }
       else{
           team = Team.giants[teamnum];
       }
        //populate image
        ImageView teamImage = (ImageView)findViewById(R.id.teamImageView);
        teamImage.setImageResource(team.getImageResourceID());
        //populate name
        TextView teamName = (TextView)findViewById(R.id.team_name);
        teamName.setText(team.getName());
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        //inflate menu to add items to the action bar
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return super.onCreateOptionsMenu(menu);
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        //get the ID of the item on the action bar that was clicked
        switch (item.getItemId()) {
            case R.id.create_order:
                //start order activity
                Intent intent = new Intent(this, OrderActivity.class);
                startActivity(intent);
                return true;
            default:
                return super.onOptionsItemSelected(item);
        }
    }
}
