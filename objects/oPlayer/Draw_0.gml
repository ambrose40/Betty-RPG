draw_sprite(sShadow,0,floor(x),floor(y));

if (invulnerable != 0) && ((invulnerable mod 4 < 2) == 0) && (flash == 0) 
{ 
	// skip draw
	
} else {
	if (flash != 0) {
		shader_set(flashShader);
		uFlash = shader_get_uniform(flashShader,"flash");
		uRColor = shader_get_uniform(flashShader,"r_color");
		uGColor = shader_get_uniform(flashShader,"g_color");
		uBColor = shader_get_uniform(flashShader,"b_color");
		
		shader_set_uniform_f(uFlash, flash);
		shader_set_uniform_f(uRColor, r_color);
		shader_set_uniform_f(uGColor, g_color);
		shader_set_uniform_f(uBColor, b_color);
	}
	draw_sprite_ext(
		sprite_index,
		image_index,
		floor(x),
		floor(y-z),
		image_xscale,
		image_yscale,
		image_angle,
		image_blend,
		image_alpha
	)
	
	if (shader_current() != -1) shader_reset();
}