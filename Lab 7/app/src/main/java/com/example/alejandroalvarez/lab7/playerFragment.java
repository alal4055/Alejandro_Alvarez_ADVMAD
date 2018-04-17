package com.example.alejandroalvarez.lab7;


import android.app.Dialog;
import android.content.Context;
import android.os.Bundle;
import android.app.Fragment;
import android.view.ContextMenu;
import android.view.LayoutInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;

import java.util.ArrayList;


/**
 * A simple {@link Fragment} subclass.
 */
public class playerFragment extends Fragment implements View.OnClickListener {

    //array adapter
    private ArrayAdapter<String> adapter;

    private long teamId; //id of the team

    public playerFragment() {
        // Required empty public constructor
    }


    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        if (savedInstanceState !=null){
            teamId = savedInstanceState.getLong("teamId");
        }
        return inflater.inflate(R.layout.fragment_player, container, false);
    }

    @Override public void onStart(){
        super.onStart();
        View view = getView();
        ListView listPlayers = (ListView) view.findViewById(R.id.playerListView);
        // get player data
        ArrayList<String> teamList = new ArrayList<String>();
        teamList = Players.teams[(int)teamId].getTeamPlayers();
        //set array adapter
        adapter = new ArrayAdapter<String>(getActivity(), android.R.layout.simple_list_item_1, teamList);

        //put array adapter to the list view
        listPlayers.setAdapter(adapter);

        Button addPlayerButton = (Button) view.findViewById(R.id.addPlayerButton);
        addPlayerButton.setOnClickListener(this);

        registerForContextMenu(listPlayers);
    }

    @Override public void onSaveInstanceState(Bundle savedInstanceState){
        savedInstanceState.putLong("teamId", teamId);
    }

    //set the team id
    public void setTeam(long id){
        this.teamId = id;
    }

    //create interface
    interface ButtonClickListener{
        void addplayerclicked(View view);
    }
    //create listener
    private ButtonClickListener listener;
    @Override public void onAttach(Context context){
        super.onAttach(context);
        //attaches the context to the listener
        listener = (ButtonClickListener)context;
    }

    @Override public void onClick(View view){
        if (listener !=null){
            listener.addplayerclicked(view);
        }
    }

    public void addplayer(){
        final Dialog dialog = new Dialog(getActivity());
        dialog.setContentView(R.layout.dialog_box);
        dialog.setTitle("Add Player");
        dialog.setCancelable(true);
        final EditText editText = (EditText) dialog.findViewById(R.id.editTextPlayer);
        Button button = (Button) dialog.findViewById(R.id.addButton);
        button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String playerName = editText.getText().toString();
                // add player
                if(!playerName.isEmpty()){
                    Players.teams[(int) teamId].getTeamPlayers().add(playerName);
                    //refresh the list view
                    playerFragment.this.adapter.notifyDataSetChanged();
                }
                dialog.dismiss();
            }
        });
        dialog.show();
    }

    @Override public void onCreateContextMenu(ContextMenu menu, View view, ContextMenu.ContextMenuInfo menuInfo){
        super.onCreateContextMenu(menu, view, menuInfo);
        //cast ContextMenu.ContextMenuInfo to AdapterView.AdapterContextMenuInfo since we're using an adapter
        AdapterView.AdapterContextMenuInfo adapterContextMenuInfo = (AdapterView.AdapterContextMenuInfo) menuInfo;
        //get player name that was pressed
        String playername = adapter.getItem(adapterContextMenuInfo.position);
        //set the menu
        menu.setHeaderTitle("Delete " + playername);
        //add the choices
        menu.add(1, 1, 1, "Yes");
        menu.add(2, 2, 2, "No");
    }

    @Override public boolean onContextItemSelected(MenuItem item){
        //get the id of the item
        int itemId = item.getItemId();
        if (itemId == 1) {
            //if yes was pressed
            //get the position of the menu item
            AdapterView.AdapterContextMenuInfo info = (AdapterView.AdapterContextMenuInfo)
                    item.getMenuInfo();
            //remove the player
            Players.teams[(int) teamId].getTeamPlayers().remove(info.position);
            //reload the list view
            playerFragment.this.adapter.notifyDataSetChanged();
        }
        return true;
    }
}

