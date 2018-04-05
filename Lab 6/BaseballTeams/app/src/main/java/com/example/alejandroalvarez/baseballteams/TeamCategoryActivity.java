package com.example.alejandroalvarez.baseballteams;

import android.app.Activity;
import android.app.ListActivity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.view.Menu;
import android.view.MenuItem;
import android.content.Intent;

public class TeamCategoryActivity extends ListActivity {

    private String teamtype;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        Intent i = getIntent();
        teamtype = i.getStringExtra("teamtype");
        //get the list view
        ListView listTeams = getListView();
        //define an array adapter
        ArrayAdapter<Team> listAdapter;
        //initialize the array adapter with the right list of bulbs
        switch (teamtype){
            case "Rockies":
                listAdapter = new ArrayAdapter<Team>(this, android.R.layout.simple_list_item_1, Team.rockies);
                break;
            case "Dodgers":
                listAdapter = new ArrayAdapter<Team>(this, android.R.layout.simple_list_item_1, Team.dodgers);
                break;
            case "Giants":
                listAdapter = new ArrayAdapter<Team>(this, android.R.layout.simple_list_item_1, Team.giants);
                break;
            default: listAdapter = new ArrayAdapter<Team>(this, android.R.layout.simple_list_item_1, Team.rockies);
        }
        //set the array adapter on the list view
        listTeams.setAdapter(listAdapter);
    }

    @Override
    public void onListItemClick(ListView listView, View view, int position, long id){
        Intent intent = new Intent(TeamCategoryActivity.this, TeamActivity.class);
        intent.putExtra("teamid", (int) id);
        intent.putExtra("teamtype", teamtype);
        startActivity(intent);
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
