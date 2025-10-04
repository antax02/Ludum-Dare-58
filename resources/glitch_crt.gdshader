shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

uniform float scanline_count : hint_range(0.0, 1080.0) = 240.0;
uniform float scanline_strength : hint_range(0.0, 1.0) = 0.3;
uniform float scanline_speed : hint_range(0.0, 2.0) = 0.1;
uniform float shake_power = 0.03;
uniform float shake_rate : hint_range( 0.0, 1.0 ) = 0.2;
uniform float shake_speed = 5.0;
uniform float shake_block_size = 30.5;
uniform float shake_color_rate : hint_range( 0.0, 1.0 ) = 0.01;

float random( float seed )
{
	return fract( 543.2543 * sin( dot( vec2( seed, seed ), vec2( 3525.46, -54.3415 ) ) ) );
}
void fragment( )
{
	float enable_shift = float(
		random( trunc( TIME * shake_speed ) )
	<	shake_rate
	);
	
	vec2 fixed_uv = SCREEN_UV;
	fixed_uv.x += (
		random(
			( trunc( SCREEN_UV.y * shake_block_size ) / shake_block_size )
		+	TIME
		) - 0.5
	) * shake_power * enable_shift;
	
	vec4 pixel_color = textureLod( SCREEN_TEXTURE, fixed_uv, 0.0 );
	pixel_color.r = mix(
		pixel_color.r
	,	textureLod( SCREEN_TEXTURE, fixed_uv + vec2( shake_color_rate, 0.0 ), 0.0 ).r
	,	enable_shift
	);
	pixel_color.b = mix(
		pixel_color.b
	,	textureLod( SCREEN_TEXTURE, fixed_uv + vec2( -shake_color_rate, 0.0 ), 0.0 ).b
	,	enable_shift
	);
	
	float scanline = sin((UV.y + TIME * scanline_speed) * scanline_count * 3.14159 * 2.0);
	scanline = 1.0 - (scanline * 0.5 + 0.5) * scanline_strength;
	
	pixel_color.rgb *= scanline;
	
	COLOR = pixel_color;
}