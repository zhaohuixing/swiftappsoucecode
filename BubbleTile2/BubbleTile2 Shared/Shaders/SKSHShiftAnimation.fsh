/**
Workspace:      BubbleTile2
Project:     BubbleTile2
Target:      BubbleTile2
Package:     BubbleTile2
File:        SKSHShiftAnimation.fsh

Created by: Zhaohui Xing on 05/18/20
Copyright (c) 2020 Zhaohui Xing. All rights reserved.
*/

void main() {
    vec4 current_color = SKDefaultShading();
    float alpha = current_color.a*0.4;
    vec3 outputColor = current_color.rgb;
    gl_FragColor = vec4(outputColor, alpha);
}
