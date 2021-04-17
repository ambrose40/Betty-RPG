/// @desc Entity Essentials
z = 0;
flash = 0;
r_color = 1;
g_color = 0;
b_color = 0;
lifted = 0;
thrown = false;
flashShader = shWhiteFlash;

uFlash = shader_get_uniform(flashShader,"flash");
uRColor = shader_get_uniform(flashShader,"r_color");
uGColor = shader_get_uniform(flashShader,"g_color");
uBColor = shader_get_uniform(flashShader,"b_color");

liftZ[0] = 13;
liftZ[1] = 14;
liftZ[2] = 15;
liftZ[3] = 14;
liftZ[4] = 13;
liftZ[5] = 14;
liftZ[6] = 15;
liftZ[7] = 14;
entityDropList = -1;
grav = 0;
old_id = id;
/// Get New Tilemap
collisionMap = layer_tilemap_get_id(layer_get_id("Col"));