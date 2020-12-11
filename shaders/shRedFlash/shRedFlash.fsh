//
// Add flash value to RGB (more white the higher flash is)
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform float flash;
uniform float r_color;
uniform float g_color;
uniform float b_color;

void main()
{
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	gl_FragColor = vec4(
	gl_FragColor.r + flash * r_color,
	gl_FragColor.g - flash * g_color,
	gl_FragColor.b - flash * b_color,
	gl_FragColor.a);
}
