// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Custom/displacement"
{
	Properties
	{
		_Wave_height("Wave_height", 2D) = "white" {}
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_TextureSample1("Texture Sample 1", 2D) = "white" {}
		_Wave_normal("Wave_normal", 2D) = "white" {}
		_EdgeLength ( "Edge length", Range( 2, 50 ) ) = 2
		_Colordeep("Color deep", Color) = (0,0.3584906,0.3344465,0)
		_Colorshadow("Color shadow", Color) = (0.3858135,0.7007851,0.9622642,0)
		_Smoothness("Smoothness", Range( 0 , 1)) = 0
		_Wavelength("Wave length", Range( 0.05 , 300)) = 10
		_Amplitude("Amplitude", Range( 0 , 10)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityStandardUtils.cginc"
		#include "Tessellation.cginc"
		#pragma target 4.6
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc tessellate:tessFunction 
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
			INTERNAL_DATA
		};

		uniform sampler2D _Wave_height;
		uniform float _Wavelength;
		uniform sampler2D _TextureSample0;
		uniform float _Amplitude;
		uniform sampler2D _Wave_normal;
		uniform sampler2D _TextureSample1;
		uniform float4 _Colordeep;
		uniform float4 _Colorshadow;
		uniform float _Smoothness;
		uniform float _EdgeLength;

		float4 tessFunction( appdata_full v0, appdata_full v1, appdata_full v2 )
		{
			return UnityEdgeLengthBasedTess (v0.vertex, v1.vertex, v2.vertex, _EdgeLength);
		}

		void vertexDataFunc( inout appdata_full v )
		{
			float2 temp_cast_0 = (_Wavelength).xx;
			float2 uv_TexCoord14 = v.texcoord.xy * temp_cast_0;
			float2 panner15 = ( 1.0 * _Time.y * float2( 0.005,0.01 ) + uv_TexCoord14);
			float2 panner16 = ( 1.0 * _Time.y * float2( -0.02,-0.01 ) + uv_TexCoord14);
			float3 ase_vertexNormal = v.normal.xyz;
			v.vertex.xyz += ( ( ( tex2Dlod( _Wave_height, float4( panner15, 0, 0.0) ).g + tex2Dlod( _TextureSample0, float4( panner16, 0, 0.0) ).g ) * 0.5 ) * _Amplitude * ase_vertexNormal );
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 temp_cast_0 = (_Wavelength).xx;
			float2 uv_TexCoord14 = i.uv_texcoord * temp_cast_0;
			float2 panner15 = ( 1.0 * _Time.y * float2( 0.005,0.01 ) + uv_TexCoord14);
			float2 panner16 = ( 1.0 * _Time.y * float2( -0.02,-0.01 ) + uv_TexCoord14);
			float3 temp_output_19_0 = BlendNormals( tex2D( _Wave_normal, panner15 ).rgb , tex2D( _TextureSample1, panner16 ).rgb );
			o.Normal = temp_output_19_0;
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float fresnelNdotV25 = dot( temp_output_19_0, ase_worldViewDir );
			float fresnelNode25 = ( 0.0 + 1.0 * pow( 1.0 - fresnelNdotV25, 1.366 ) );
			float4 lerpResult26 = lerp( _Colordeep , _Colorshadow , fresnelNode25);
			o.Albedo = lerpResult26.rgb;
			o.Smoothness = _Smoothness;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15700
1320;92;600;926;2103.849;384.0774;1.303492;True;False
Node;AmplifyShaderEditor.RangedFloatNode;9;-1968.901,38.79998;Float;False;Property;_Wavelength;Wave length;12;0;Create;True;0;0;False;0;10;2;0.05;300;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;14;-1681.441,16.25434;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;15;-1431.741,13.65433;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.005,0.01;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;16;-1396.807,503.321;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;-0.02,-0.01;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;13;-1038.941,-115.0457;Float;True;Property;_Wave_normal;Wave_normal;3;0;Create;True;0;0;False;0;None;f6df680ea94508b4fbc3c3bececebd35;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;18;-1052.007,374.621;Float;True;Property;_TextureSample1;Texture Sample 1;2;0;Create;True;0;0;False;0;None;f6df680ea94508b4fbc3c3bececebd35;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;12;-1038.041,112.4544;Float;True;Property;_Wave_height;Wave_height;0;0;Create;True;0;0;False;0;None;f6df680ea94508b4fbc3c3bececebd35;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;17;-1051.107,602.121;Float;True;Property;_TextureSample0;Texture Sample 0;1;0;Create;True;0;0;False;0;None;f6df680ea94508b4fbc3c3bececebd35;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;29;-912.4625,-322.8647;Float;False;Constant;_Float0;Float 0;12;0;Create;True;0;0;False;0;1.366;1.366;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.BlendNormalsNode;19;-652.1179,-142.0583;Float;True;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;20;-706.4388,408.8546;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;22;-500.8705,195.5569;Float;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FresnelNode;25;-678.1107,-434.5448;Float;True;Standard;WorldNormal;ViewDir;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;-518.439,412.7546;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-501.5004,762.0992;Float;False;Property;_Amplitude;Amplitude;13;0;Create;True;0;0;False;0;0;0.1;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;24;-689.1767,-616.3099;Float;False;Property;_Colorshadow;Color shadow;10;0;Create;True;0;0;False;0;0.3858135,0.7007851,0.9622642,0;0.2946778,0.7041652,0.8113208,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;23;-747.1746,-811.9158;Float;False;Property;_Colordeep;Color deep;9;0;Create;True;0;0;False;0;0,0.3584906,0.3344465,0;0,0.6037736,0.5639644,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;-219.0001,320.9999;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-320.1364,135.7455;Float;False;Property;_Smoothness;Smoothness;11;0;Create;True;0;0;False;0;0;0.693;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;26;-296.456,-703.9339;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-0.6999996,-134.5;Float;False;True;6;Float;ASEMaterialInspector;0;0;Standard;Custom/displacement;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;True;2;2;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;4;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;14;0;9;0
WireConnection;15;0;14;0
WireConnection;16;0;14;0
WireConnection;13;1;15;0
WireConnection;18;1;16;0
WireConnection;12;1;15;0
WireConnection;17;1;16;0
WireConnection;19;0;13;0
WireConnection;19;1;18;0
WireConnection;20;0;12;2
WireConnection;20;1;17;2
WireConnection;25;0;19;0
WireConnection;25;3;29;0
WireConnection;21;0;20;0
WireConnection;6;0;21;0
WireConnection;6;1;7;0
WireConnection;6;2;22;0
WireConnection;26;0;23;0
WireConnection;26;1;24;0
WireConnection;26;2;25;0
WireConnection;0;0;26;0
WireConnection;0;1;19;0
WireConnection;0;4;11;0
WireConnection;0;11;6;0
ASEEND*/
//CHKSM=250EC239F5132269C11F28CDDEE8484167AE4767