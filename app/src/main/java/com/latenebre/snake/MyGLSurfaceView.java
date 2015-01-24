package com.latenebre.snake;

import android.content.Context;
import android.opengl.GLSurfaceView;

/**
 * Created by luke on 24.01.15.
 */
class MyGLSurfaceView extends GLSurfaceView {

    public MyGLSurfaceView(Context context){
        super(context);

        setEGLContextClientVersion(2);

        // Set the Renderer for drawing on the GLSurfaceView
        setRenderer(new MyGLRenderer());
        setRenderMode(GLSurfaceView.RENDERMODE_WHEN_DIRTY);
    }
}