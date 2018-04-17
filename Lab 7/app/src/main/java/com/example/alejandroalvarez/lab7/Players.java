package com.example.alejandroalvarez.lab7;

import java.util.ArrayList;
import java.util.Arrays;

/**
 * Created by alejandroalvarez on 4/16/18.
 */

public class Players {
    private String team;
    private ArrayList<String> teamPlayers = new ArrayList<>();
    //constructor
    private Players(String te, ArrayList<String> teams) {
        this.team = te;
        this.teamPlayers = new ArrayList<String>(teams);
    }
    public static final Players[] teams = {
            new Players("Rockies", new ArrayList<String>(Arrays.asList("Charlie Blackmon", "Nolan Arenado", "Trevor Story", "Carlos Gonzalez", "Jon Gray"))),
            new Players("Dodgers", new ArrayList<String>(Arrays.asList("Clayton Kershaw", "Matt Kemp", "Justin Turner", "Yasiel Puig", "Corey Seager"))),
            new Players("Padres", new ArrayList<String>(Arrays.asList("Will Myers", "Eric Hosmer", "Christian Villanueva", "Chase Headley", "Joey Lucchesi"))),
            new Players("Giants", new ArrayList<String>(Arrays.asList("Andrew McCutchen", "Buster Posey", "Evan Longoria", "Hunter Pence", "Pablo Sandoval")))
    };

    public String getTeam(){
        return team;
    }
    public ArrayList<String> getTeamPlayers(){
        return teamPlayers;
    }
    public String toString(){
        return this.team;
    }
}