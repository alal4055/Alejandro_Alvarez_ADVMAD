package com.example.alejandroalvarez.baseballteams;

/**
 * Created by alejandroalvarez on 4/4/18.
 */

public class Team {

    private String name;
    private int imageResourceID;
    //constructor
    private Team(String newname, int newID){
        this.name = newname;
        this.imageResourceID = newID;
    }
    public static final Team[] rockies = {
            new Team("Charlie Blackmon", R.drawable.charlieblackmon),
            new Team("Nolan Arenado", R.drawable.nolanarenado),
            new Team("Carlos Gonzalez", R.drawable.carlosgonzalez),
            new Team("Trevor Story", R.drawable.trevorstory),
    };

    public static final Team[] dodgers = {
            new Team("Clayton Kershaw", R.drawable.claytonkershaw),
            new Team("Matt Kemp", R.drawable.mattkemp),
            new Team("Justin Turner", R.drawable.justinturner),
            new Team("Yasiel Puig", R.drawable.yasielpuig),
    };

    public static final Team[] giants = {
            new Team("Andrew McCutchen", R.drawable.andrewmccutchen),
            new Team("Buster Posey", R.drawable.busterposey),
            new Team("Evan Longoria", R.drawable.evanlongoria),
            new Team("Pablo Sandoval", R.drawable.pablosandoval),
    };

    public String getName(){
        return name;
    }

    public int getImageResourceID(){
        return imageResourceID;
    }

    //the string representation of a tulip is its name
    public String toString(){
        return this.name;
    }
}
