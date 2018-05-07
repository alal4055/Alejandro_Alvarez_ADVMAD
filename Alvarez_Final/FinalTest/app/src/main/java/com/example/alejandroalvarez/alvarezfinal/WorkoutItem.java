package com.example.alejandroalvarez.alvarezfinal;

/**
 * Created by alejandroalvarez on 5/6/18.
 */

public class WorkoutItem {
    private String id;
    private String name;
    private String url;

    public WorkoutItem(){

    }

    public WorkoutItem(String newid, String newName, String newURL){
        id = newid;
        name = newName;
        url = newURL;
    }

    public String getId() {
        return id;
    }

    public String getName(){
        return name;
    }

    public String getURL(){
        return url;
    }

    public String toString(){
        return this.name;
    }
}
