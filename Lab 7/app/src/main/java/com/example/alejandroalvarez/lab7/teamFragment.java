package com.example.alejandroalvarez.lab7;


import android.content.Context;
import android.os.Bundle;
import android.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;


/**
 * A simple {@link Fragment} subclass.
 */
public class teamFragment extends Fragment implements AdapterView.OnItemClickListener {


    public teamFragment() {
        // Required empty public constructor
    }


    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_team, container, false);
    }

    @Override
    public void onStart() {
        super.onStart();
        View view = getView();
        if (view != null){
            //load data into fragment
            //get the list view
            ListView listTeams = (ListView) view.findViewById(R.id.listView);
            //define an array adapter
            ArrayAdapter<Players> listAdapter = new ArrayAdapter<Players>(getActivity(), android.R.layout.simple_list_item_1, Players.teams);
            //set the array adapter on the list view
            listTeams.setAdapter(listAdapter);
            //attach the listener to the listview
            listTeams.setOnItemClickListener(this);
        }
    }

    //create interface
    interface TeamListListener{
        void itemClicked(long id);
    }

    //create listener
    private TeamListListener listener;
    @Override public void onAttach(Context context){
        super.onAttach(context);
        //attaches the context to the listener
        listener = (TeamListListener) context;
    }

    @Override public void onItemClick(AdapterView<?> parent, View view, int position, long id){
        if (listener != null){
            //item was clicked
            listener.itemClicked(id);
        }
    }
}
