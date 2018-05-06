package com.example.alejandroalvarez.lab9;

/**
 * Created by alejandroalvarez on 5/6/18.
 */

public class WorkoutItem {

    private String id;
    private String name;
    private String time;

    public WorkoutItem(){

    }

    public WorkoutItem(String newid, String newName, String newTime){
        id = newid;
        name = newName;
        time = newTime;
    }

    public String getId() {
        return id;
    }

    public String getName(){
        return name;
    }

    public String gettime(){
        return time;
    }

    public String toString(){
        return this.name;
    }
}
