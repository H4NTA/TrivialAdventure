// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Custom/displacement"
{
	Properties
	{
		_EdgeLength ( "Edge length", Range( 2, 50 ) ) = 15
		[HDR]_Color("Color", Color) = (0.08018869,0.6248133,1,0)
		_Wave_height("Wave_height", 2D) = "white" {}
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_Wave_normal("Wave_normal", 2D) = "bump" {}
		_TextureSample1("Texture Sample 1", 2D) = "bump" {}
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
		};

		uniform sampler2D _Wave_height;
		uniform float _Wavelength;
		uniform sampler2D _TextureSample0;
		uniform float _Amplitude;
		uniform sampler2D _Wave_normal;
		uniform sampler2D _TextureSample1;
		uniform float4 _Color;
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
			float2 panner15 = ( 1.0 * _Time.y * float2( 0.05,0.08 ) + uv_TexCoord14);
			float2 panner16 = ( 1.0 * _Time.y * float2( -0.05,-0.02 ) + uv_TexCoord14);
			float3 ase_vertexNormal = v.normal.xyz;
			v.vertex.xyz += ( ( ( tex2Dlod( _Wave_height, float4( panner15, 0, 0.0) ).g + tex2Dlod( _TextureSample0, float4( panner16, 0, 0.0) ).g ) * 0.5 ) * _Amplitude * ase_vertexNormal );
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 temp_cast_0 = (_Wavelength).xx;
			float2 uv_TexCoord14 = i.uv_texcoord * temp_cast_0;
			float2 panner15 = ( 1.0 * _Time.y * float2( 0.05,0.08 ) + uv_TexCoord14);
			float2 panner16 = ( 1.0 * _Time.y * float2( -0.05,-0.02 ) + uv_TexCoord14);
			o.Normal = BlendNormals( UnpackNormal( tex2D( _Wave_normal, panner15 ) ) , UnpackNormal( tex2D( _TextureSample1, panner16 ) ) );
			o.Albedo = _Color.rgb;
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
1230;92;690;926;932.986;-11.54665;1.3;True;False
Node;AmplifyShaderEditor.RangedFloatNode;9;-1968.901,38.79998;Float;False;Property;_Wavelength;Wave length;11;0;Create;True;0;0;False;0;10;1000;0.05;300;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;14;-1681.441,16.25434;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;15;-1431.741,13.65433;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.05,0.08;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;16;-1396.807,503.321;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;-0.05,-0.02;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;17;-1051.107,602.121;Float;True;Property;_TextureSample0;Texture Sample 0;7;0;Create;True;0;0;False;0;None;9a8d7d2e5e4c285469e1c3d2c6d7fc0a;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;12;-1038.041,112.4544;Float;True;Property;_Wave_height;Wave_height;6;0;Create;True;0;0;False;0;None;9a8d7d2e5e4c285469e1c3d2c6d7fc0a;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;20;-706.4388,408.8546;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;18;-1052.007,374.621;Float;True;Property;_TextureSample1;Texture Sample 1;9;0;Create;True;0;0;False;0;None;b5adeb8f13d463c4da3da690b6e1cd44;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;7;-501.5004,762.0992;Float;False;Property;_Amplitude;Amplitude;12;0;Create;True;0;0;False;0;0;0.2;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;22;-500.8705,195.5569;Float;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;13;-1038.941,-115.0457;Float;True;Property;_Wave_normal;Wave_normal;8;0;Create;True;0;0;False;0;None;b5adeb8f13d463c4da3da690b6e1cd44;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;-518.439,412.7546;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;-219.0001,320.9999;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;10;-465.8999,-246.9;Float;False;Property;_Color;Color;5;1;[HDR];Create;True;0;0;False;0;0.08018869,0.6248133,1,0;0,0.3137255,1,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BlendNormalsNode;19;-506.2387,-65.64561;Float;True;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-266.6,117.9;Float;False;Property;_Smoothness;Smoothness;10;0;Create;True;0;0;False;0;0;0.25;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-0.6999996,-134.5;Float;False;True;6;Float;ASEMaterialInspector;0;0;Standard;Custom/displacement;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;True;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;0;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;14;0;9;0
WireConnection;15;0;14;0
WireConnection;16;0;14;0
WireConnection;17;1;16;0
WireConnection;12;1;15;0
WireConnection;20;0;12;2
WireConnection;20;1;17;2
WireConnection;18;1;16;0
WireConnection;13;1;15;0
WireConnection;21;0;20;0
WireConnection;6;0;21;0
WireConnection;6;1;7;0
WireConnection;6;2;22;0
WireConnection;19;0;13;0
WireConnection;19;1;18;0
WireConnection;0;0;10;0
WireConnection;0;1;19;0
WireConnection;0;4;11;0
WireConnection;0;11;6;0
ASEEND*/
//CHKSM=0D3FC8838FFD36FF399AFE3E327357F0F423BA7D