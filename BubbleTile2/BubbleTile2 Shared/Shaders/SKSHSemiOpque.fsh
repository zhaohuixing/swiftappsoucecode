/**
Workspace:      BubbleTile2
Project:     BubbleTile2
Target:      BubbleTile2
Package:     BubbleTile2
File:        SKSHSemiOpque.fsh

Created by: Zhaohui Xing on 05/18/20
Copyright (c) 2020 Zhaohui Xing. All rights reserved.
*/

void main() {
    vec4 current_color = SKDefaultShading();
    float alpha = current_color.a;
    vec3 outputColor = current_color.rgb*0.5;
    gl_FragColor = vec4(outputColor, alpha);
}
