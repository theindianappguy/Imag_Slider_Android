package com.theindianappguy.autoimageslider;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.viewpager.widget.PagerAdapter;

public class CustomSwipeAdapter extends PagerAdapter {

    private  int[] imageResources = {R.drawable.car_image_1,R.drawable.car_image_2,R.drawable.car_image_3};
    private Context context;
    private LayoutInflater layoutInflater;

    public CustomSwipeAdapter(Context ctx){
        this.context = ctx;
    }

    @Override
    public int getCount() {
        return imageResources.length;
    }

    @Override
    public boolean isViewFromObject(@NonNull View view, @NonNull Object object) {
        return (view==(RelativeLayout)object );
    }

    @NonNull
    @Override
    public Object instantiateItem(@NonNull ViewGroup container, int position) {
        layoutInflater = (LayoutInflater)context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        View item_view = layoutInflater.inflate(R.layout.slide_layout,container,false);
        ImageView imageView = item_view.findViewById(R.id.image_view);
        TextView textView = item_view.findViewById(R.id.text);

        imageView.setImageResource(imageResources[position]);
        textView.setText("Heading!");
        container.addView(item_view);
        return item_view;
      /*  return super.instantiateItem(container, position);*/
    }

    @Override
    public void destroyItem(@NonNull ViewGroup container, int position, @NonNull Object object) {
        container.removeView((RelativeLayout)object);
    }
}
