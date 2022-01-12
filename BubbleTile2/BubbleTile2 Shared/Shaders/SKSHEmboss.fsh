/**
Workspace:      BubbleTile2
Project:     BubbleTile2
Target:      BubbleTile2
Package:     BubbleTile2
File:        SKSHEmboss.fsh

Created by: Zhaohui Xing on 05/17/20
Copyright (c) 2020 Zhaohui Xing. All rights reserved.
*/

void main() {
    vec4 current_color = SKDefaultShading();

    // if it's not transparent
    if(current_color.a > 0.0) {
        // find the size of one pixel by reading the input size
        vec2 pixel_size = 1.0 / a_size;

        vec4 new_color = vec4(vec3(u_grayscale), 1);

        // move up one pixel diagonally and read the current color, multiply it by the input strength, then add it to our pixel color
        new_color += texture2D(u_texture, v_tex_coord + pixel_size) * u_strength;

        // move down one pixel diagonally and read the current color, multiply it by the input strength, then subtract it to our pixel color
        new_color -= texture2D(u_texture, v_tex_coord - pixel_size) * u_strength;

        // sum the RGB values for our new color
        float combined = new_color.r + new_color.g + new_color.b;

        // divide that sum by 3 to give us an average, and use that for the RGB values of our color
        new_color.rgb = vec3(combined / 3.0);

        // use that new color, with an alpha of 1, for our pixel color, multiplying by this pixel's alpha
        // (to avoid a hard edge) and also multiplying by the alpha for this node
        gl_FragColor = vec4(new_color.rgb, 1) * current_color.a * v_color_mix.a;
    }
    else {
        // use the current (transparent) color
        gl_FragColor = current_color;
    }
}
