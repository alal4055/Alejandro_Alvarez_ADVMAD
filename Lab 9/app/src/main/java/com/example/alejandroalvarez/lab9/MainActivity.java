package com.example.alejandroalvarez.lab9;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.design.widget.Snackbar;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.view.ContextMenu;
import android.view.View;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.TextView;

import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;

import java.util.ArrayList;
import java.util.List;

public class MainActivity extends AppCompatActivity {


    // Firebase database instance
    FirebaseDatabase database = FirebaseDatabase.getInstance();
    //Firebase database reference
    DatabaseReference ref = database.getReference();
    //Firebase database recipe node reference
    DatabaseReference workoutref = database.getReference("workouts");

    List workouts = new ArrayList<>();
    ArrayAdapter<WorkoutItem> listAdapter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        FloatingActionButton fab = (FloatingActionButton) findViewById(R.id.fab);
        fab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                LinearLayout layout = new LinearLayout(MainActivity.this);
                layout.setOrientation(LinearLayout.VERTICAL);

                final EditText nameEditText = new EditText(MainActivity.this);
                nameEditText.setHint("Workout Name");
                layout.addView(nameEditText);
                final EditText urlEditText = new EditText(MainActivity.this);
                urlEditText.setHint("Time");
                layout.addView(urlEditText);

                AlertDialog.Builder dialog = new AlertDialog.Builder(MainActivity.this);
                dialog.setTitle("Add Workout");
                dialog.setView(layout);
                dialog.setPositiveButton("Save", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        //get data
                        String workoutName = nameEditText.getText().toString();
                        String workoutTime = urlEditText.getText().toString();
                        if (workoutName.trim().length() > 0) {
                            //get id from Firebase
                            String key = workoutref.push().getKey();
                            WorkoutItem newWorkout = new WorkoutItem(key, workoutName, workoutTime);
                            //add to Firebase
                            workoutref.child(key).child("name").setValue(newWorkout.getName());
                            workoutref.child(key).child("time").setValue(newWorkout.gettime());
                        }
                    }
                });
                dialog.setNegativeButton("Cancel", null);
                dialog.show();
            }
        });

        ListView workoutList = (ListView) findViewById(R.id.listView);
        listAdapter = new ArrayAdapter<WorkoutItem>(this, android.R.layout.simple_list_item_1, workouts);
        workoutList.setAdapter(listAdapter);

        // Read from the database
        ValueEventListener firebaseListener = new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {
                workouts.clear();

                for(DataSnapshot snapshot : dataSnapshot.getChildren()){
                    String newId = snapshot.getKey();
                    WorkoutItem workoutItem = snapshot.getValue(WorkoutItem.class);
                    WorkoutItem newWorkout = new WorkoutItem(newId, workoutItem.getName(), workoutItem.gettime());
                    workouts.add(newWorkout);
                }
                listAdapter.notifyDataSetChanged();
            }

            @Override
            public void onCancelled(DatabaseError error) {
                // Failed to read value
                Log.w("oncreate", "Failed to read value.", error.toException());
            }
        };

        workoutref.addValueEventListener(firebaseListener);
        registerForContextMenu(workoutList);

        //create listener
        AdapterView.OnItemClickListener itemClickListener = new AdapterView.OnItemClickListener(){
            public void onItemClick(AdapterView<?> listView, View view, int position, long id){
                WorkoutItem workoutTapped = (WorkoutItem) workouts.get(position);
                String workoutTime = workoutTapped.gettime();
                //create new intent
                Intent intent = new Intent(MainActivity.this, WorkoutTime.class);
                intent.putExtra("time", workoutTime);
                startActivity(intent);
            }
        };
        workoutList.setOnItemClickListener(itemClickListener);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        int id = item.getItemId();

        if (id == R.id.action_settings) {
            return true;
        }

        return super.onOptionsItemSelected(item);
    }

    @Override public void onCreateContextMenu(ContextMenu menu, View view, ContextMenu.ContextMenuInfo menuInfo){
        super.onCreateContextMenu(menu, view, menuInfo);
        AdapterView.AdapterContextMenuInfo adapterContextMenuInfo = (AdapterView.AdapterContextMenuInfo) menuInfo;
        String workoutname = ((TextView) adapterContextMenuInfo.targetView).getText().toString();
        menu.setHeaderTitle("Delete " + workoutname);
        //add the choices to the menu
        menu.add(1, 1, 1, "Yes");
        menu.add(2, 2, 2, "No");
    }

    @Override public boolean onContextItemSelected(MenuItem item){
        int itemId = item.getItemId();
        if (itemId == 1) {
            AdapterView.AdapterContextMenuInfo info = (AdapterView.AdapterContextMenuInfo) item.getMenuInfo();
            WorkoutItem selectedWorkout = (WorkoutItem) workouts.get(info.position);
            String workoutid = selectedWorkout.getId();
            workoutref.child(workoutid).removeValue();
        }
        return true;
    }



}
