/// @description 
// Inherit the parent event
event_inherited();
spd = 0;
flash = 1;
bounce = 0;
r_color = 1;
g_color = 1;
b_color = 1;
uFlash = shader_get_uniform(shWhiteFlash,"flash");
uRColor = shader_get_uniform(shWhiteFlash,"r_color");
uGColor = shader_get_uniform(shWhiteFlash,"g_color");
uBColor = shader_get_uniform(shWhiteFlash,"b_color");