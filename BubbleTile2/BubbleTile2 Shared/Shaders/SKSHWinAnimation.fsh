/**
Workspace:      BubbleTile2
Project:     BubbleTile2
Target:      BubbleTile2
Package:     BubbleTile2
File:        SKSHWinAnimation.fsh

Created by: Zhaohui Xing on 05/18/20
Copyright (c) 2020 Zhaohui Xing. All rights reserved.
*/

void main() {
    vec4 current_color = SKDefaultShading();
    float phase = mod(u_time, 4);
    float alpha = current_color.a;
    vec3 outputColor = current_color.rgb;
    if (phase < 1.0) {
        outputColor = current_color.bgr;
    }
    else if (phase < 2.0)
    {
        outputColor = current_color.rgb;
    }
    else if (phase < 3.0)
    {
        outputColor = current_color.rbg;
    }
    gl_FragColor = vec4(outputColor, alpha);
}
