RSRC                    VisualShader            ��������                                            <      resource_local_to_scene    resource_name    output_port_for_preview    default_input_values    expanded_output_ports    input_name    script    parameter_name 
   qualifier    hint    min    max    step    default_value_enabled    default_value    op_type 	   function 	   operator    source    texture    texture_type    code    graph_offset    mode    modes/blend    flags/skip_vertex_transform    flags/unshaded    flags/light_only    nodes/vertex/0/position    nodes/vertex/connections    nodes/fragment/0/position    nodes/fragment/2/node    nodes/fragment/2/position    nodes/fragment/3/node    nodes/fragment/3/position    nodes/fragment/5/node    nodes/fragment/5/position    nodes/fragment/6/node    nodes/fragment/6/position    nodes/fragment/7/node    nodes/fragment/7/position    nodes/fragment/8/node    nodes/fragment/8/position    nodes/fragment/connections    nodes/light/0/position    nodes/light/connections    nodes/start/0/position    nodes/start/connections    nodes/process/0/position    nodes/process/connections    nodes/collide/0/position    nodes/collide/connections    nodes/start_custom/0/position    nodes/start_custom/connections     nodes/process_custom/0/position !   nodes/process_custom/connections    nodes/sky/0/position    nodes/sky/connections    nodes/fog/0/position    nodes/fog/connections        $   local://VisualShaderNodeInput_n5nfc ?      -   local://VisualShaderNodeFloatParameter_gghqq �      )   local://VisualShaderNodeVectorFunc_p6s02       '   local://VisualShaderNodeVectorOp_me662       '   local://VisualShaderNodeVectorOp_dx4kv  	      &   local://VisualShaderNodeTexture_ive5n �	         local://VisualShader_fbgjl �	         VisualShaderNodeInput                       uv          VisualShaderNodeFloatParameter             Pixelisation 	         
        �C         D         @                 �@         VisualShaderNodeVectorFunc                              
                                       VisualShaderNodeVectorOp                              
                 
                                       VisualShaderNodeVectorOp                              
                 
                                       VisualShaderNodeTexture                      VisualShader          B  shader_type canvas_item;
render_mode blend_mix;

uniform float Pixelisation : hint_range(256, 512, 2) = 4;
uniform sampler2D screen_tex_frg_8 : hint_screen_texture;



void fragment() {
// Input:2
	vec2 n_out2p0 = UV;


// FloatParameter:3
	float n_out3p0 = Pixelisation;


// VectorOp:6
	vec2 n_out6p0 = n_out2p0 * vec2(n_out3p0);


// VectorFunc:5
	vec2 n_out5p0 = floor(n_out6p0);


// VectorOp:7
	vec2 n_out7p0 = n_out5p0 / vec2(n_out3p0);


	vec4 n_out8p0;
// Texture2D:8
	n_out8p0 = texture(screen_tex_frg_8, n_out7p0);


// Output:0
	COLOR.rgb = vec3(n_out8p0.xyz);


}
                       
     D  4C                 
     �   B!            "   
     �  �C#            $   
      �  C%            &   
     \�  C'            (   
      C   C)            *   
     �C  C+                                                                                                                 RSRC