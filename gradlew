/*
 * Decompiled with CFR 0.0.
 *
 * Could not load the following classes:
 *  android.app.Activity
 *  android.content.ActivityNotFoundException
 *  android.content.Context
 *  android.content.Intent
 *  android.view.LayoutInflater
 *  android.view.MenuItem
 *  android.view.MenuItem$OnMenuItemClickListener
 *  android.view.View
 *  android.view.View$OnClickListener
 *  android.view.ViewGroup
 *  android.widget.ArrayAdapter
 *  android.widget.LinearLayout
 *  android.widget.TextView
 *  com.google.firebase.database.DatabaseReference
 *  com.google.firebase.database.FirebaseDatabase
 *  com.robertsimoes.shareable.Shareable
 *  com.robertsimoes.shareable.Shareable$Builder
 *  com.ksanfns.marksplus.CHAT_ACTIVITY.ListChatActivity
 *  com.ksanfns.marksplus.OTHERS.helpingclasses.SessionManagement
 *  com.ksanfns.marksplus.QuizPlay.PlayImageQuiz
 *  com.ksanfns.marksplus.QuizPlay.SimpleQuizActivity
 *  com.ksanfns.marksplus.QuizPlay.Truefalsequizplay
 *  es.dmoral.toasty.Toasty
 *  java.lang.CharSequence
 *  java.lang.Class
 *  java.lang.Object
 *  java.lang.String
 *  java.util.HashMap
 *  java.util.List
 *  ru.whalemare.sheetmenu.SheetMenu
 *  ru.whalemare.sheetmenu.SheetMenu$Builder
 */
package com.theindianappguy.dot7amin.Adapter;

import android.app.Activity;
import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;

import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;
import com.theindianappguy.dot7amin.CustomClasses.UpdatesClass;
import com.theindianappguy.dot7amin.CustomClasses.UserClass;
import com.theindianappguy.dot7amin.HelpingClasses.SessionManagement;
import com.theindianappguy.dot7amin.R;

import java.util.HashMap;
import java.util.List;

public class all_updates_list_adapter
        extends ArrayAdapter<UpdatesClass> {
    List<UpdatesClass> classh;
    private Activity context;
    SessionManagement cookie;
    TextView title, desc, no, yes;
    DatabaseReference databaseReference;
    LinearLayout actionButtons;

    /*Variables*/
    String AgentName = "";

    public all_updates_list_adapter(Activity activity, List<UpdatesClass> list) {
        super((Context) activity, R.layout.list_item_part, list);
        this.context = activity;
        this.classh = list;
    }

    public View getView(final int n, View view, ViewGroup viewGroup) {

        View view2 = this.context.getLayoutInflater().inflate(R.layout.list_item_part, null, true);
        this.cookie = new SessionManagement(this.context);
        title = view2.findViewById(R.id.title);
        desc = view2.findViewById(R.id.desc);
        actionButtons = view2.findViewById(R.id.actionButtons);
        no = view2.findViewById(R.id.no);
        yes = view2.findViewById(R.id.yes);
        databaseReference = FirebaseDatabase.getInstance().getReference().child("Admin")
                .child("Updates").child(classh.get(n).getUpdateKey());

        if(!classh.get(n).isHaveButtons()){
            actionButtons.setVisibility(View.GONE);
        }
        no.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

            }
        });
        yes.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                databaseReference.child(classh.get(n).getUpdateKey()).removeValue();
                UpdatesClass updatesClass = new UpdatesClass();
                updatesClass.setTitle("Agent Approved!");
                updatesClass.setDesc(getAgentNameFromId() + " Has been approved to join Dot7 as Agent");
                updatesClass.setApproved(true);
                updatesClass.setSeen(true);
                updatesClass.setUpdateKey(classh.get(n).getUpdateKey());
                databaseReference.setValue(updatesClass);
                Toast.makeText(context, "Agent Approved", Toast.LENGTH_SHORT).show();
                notifyDataSetChanged();
            }
        });

        title.setText(((classh.get(n)).getTitle()));
        desc.setText(((classh.get(n)).getDesc()));

        return view2;
    }

    private String getAgentNameFromId() {
        DatabaseReference databaseReference = FirebaseDatabase.getInstance().getReference();
        databaseReference.addListenerForSingleValueEvent(new ValueEventListener() {
            @Override
            public void onDataChange(@NonNull DataSnapshot dataSnapshot) {
                UserClass userClass = dataSnapshot.getValue(UserClass.class);
                AgentName = userClass.getUsername();
            }

            @Override
            public void onCancelled(@NonNull DatabaseError databaseError) {

            }
        });

        return AgentName;
    }

}

                                                                                                                                                                                                     