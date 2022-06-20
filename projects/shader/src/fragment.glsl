precision mediump float;

varying vec2 vUvs;

uniform float uTime;
uniform sampler2D uSampler;
uniform vec2 uBounds;

const float Pi = 6.28318530718; // Pi*2    
// GAUSSIAN BLUR SETTINGS {{{
const float Directions = 32.0; // BLUR DIRECTIONS (Default 16.0 - More is better but slower)
const float Quality = 4.0; // BLUR QUALITY (Default 4.0 - More is better but slower)
const float Size = 10.0; // BLUR SIZE (Radius)
// GAUSSIAN BLUR SETTINGS }}}

void main() {
    vec2 Radius = Size / uBounds.xy;
    // // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = gl_FragCoord.xy / uBounds.xy;
    // // Pixel colour
    vec4 Color = texture2D(uSampler, uv);

    // Blur calculations
    for(float d = 0.0; d < Pi; d += Pi / Directions)
    {
		for(float i = 1.0 / Quality; i <= 1.0; i += 1.0 / Quality)
        {
			Color += texture2D(uSampler, uv + vec2(cos(d), sin(d)) * sin(uTime) * Radius * i);		
        }
    }
    
    // Output to screen
    Color /= Quality * Directions - 15.0;
    gl_FragColor = Color;

    // vec4 color = vec4(0.0);
    // vec2 off1 = vec2(1.411764705882353) * Directions;
    // vec2 off2 = vec2(3.2941176470588234) * Directions;
    // vec2 off3 = vec2(5.176470588235294) * Directions;
    // color += texture2D(uSampler, uv) * 0.1964825501511404;
    // color += texture2D(uSampler, uv + (off1 / uBounds)) * 0.2969069646728344;
    // color += texture2D(uSampler, uv - (off1 / uBounds)) * 0.2969069646728344;
    // color += texture2D(uSampler, uv + (off2 / uBounds)) * 0.09447039785044732;
    // color += texture2D(uSampler, uv - (off2 / uBounds)) * 0.09447039785044732;
    // color += texture2D(uSampler, uv + (off3 / uBounds)) * 0.010381362401148057;
    // color += texture2D(uSampler, uv - (off3 / uBounds)) * 0.010381362401148057;
    // gl_FragColor = color;

    // gl_FragColor = texture2D(uSampler, vUvs);
    // gl_FragColor = texture2D(uSampler, vUvs + sin( (uTime + (vUvs.x) * 14.) ) * 0.1 );
}