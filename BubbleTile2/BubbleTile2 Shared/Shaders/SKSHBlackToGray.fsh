/**
Workspace:      BubbleTile2
Project:     BubbleTile2
Target:      BubbleTile2
Package:     BubbleTile2
File:        SKSHBlackToGray.fsh

Created by: Zhaohui Xing on 05/18/20
Copyright (c) 2020 Zhaohui Xing. All rights reserved.
*/

void main() {
    vec4 current_color = SKDefaultShading();

    // if it's not transparent
    if(current_color.r <= 0.05
       && current_color.g <= 0.05
       && current_color.b <= 0.05
       && 0.98 <= current_color.a)
    {
        gl_FragColor = vec4(vec3(0.5), 1);
    }
    else {
        // use the current (transparent) color
        gl_FragColor = current_color;
    }
}
