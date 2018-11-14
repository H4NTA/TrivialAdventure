// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "New Amplify Shader"
{
	Properties
	{
		_NormalMap2strength("Normal Map 2 strength", Range( 0 , 1)) = 0
		_Normalmap("Normal map", 2D) = "bump" {}
		_Normalmap1strength("Normal map 1 strength", Range( 0 , 1)) = 0
		_Normalblendstrength("Normal blend strength", Range( 0 , 1)) = 0
		_UV1Tilling("UV 1 Tilling", Float) = 1
		_Colordeep("Color deep", Color) = (0,0.3584906,0.3344465,0)
		_Colorshadow("Color shadow", Color) = (0.3858135,0.7007851,0.9622642,0)
		_UV1Animator("UV 1 Animator", Vector) = (0,0,0,0)
		_UV2Animator("UV 2 Animator", Vector) = (0,0,0,0)
		_UV2Tilling("UV 2 Tilling", Float) = 1
		_Glossines("Glossines", Range( 0 , 1)) = 0
		_TextureSample1("Texture Sample 1", 2D) = "white" {}
		_TextureSample2("Texture Sample 2", 2D) = "white" {}
		_Amplitude("Amplitude", Range( 0 , 10)) = 0
		_Float1("Float 1", Range( 0 , 10)) = 7.294117
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityStandardUtils.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float3 worldPos;
			INTERNAL_DATA
		};

		uniform sampler2D _TextureSample2;
		uniform float _Float1;
		uniform sampler2D _TextureSample1;
		uniform float _Amplitude;
		uniform sampler2D _Normalmap;
		uniform float _Normalmap1strength;
		uniform float2 _UV1Animator;
		uniform float _UV1Tilling;
		uniform float _NormalMap2strength;
		uniform float2 _UV2Animator;
		uniform float _UV2Tilling;
		uniform float _Normalblendstrength;
		uniform float4 _Colordeep;
		uniform float4 _Colorshadow;
		uniform float _Glossines;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float2 temp_cast_0 = (_Float1).xx;
			float2 uv_TexCoord57 = v.texcoord.xy * temp_cast_0;
			float2 panner56 = ( 1.0 * _Time.y * float2( 0,0 ) + uv_TexCoord57);
			float3 ase_vertexNormal = v.normal.xyz;
			v.vertex.xyz += ( ( ( tex2Dlod( _TextureSample2, float4( panner56, 0, 0.0) ).g + tex2Dlod( _TextureSample1, float4( panner56, 0, 0.0) ).g ) * 0.0 ) * ase_vertexNormal * _Amplitude );
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float3 ase_worldPos = i.worldPos;
			float2 appendResult2 = (float2(ase_worldPos.x , ase_worldPos.z));
			float2 WorldUV5 = ( appendResult2 / 1.0 );
			float2 panner32 = ( _Time.x * _UV1Animator + ( WorldUV5 * _UV1Tilling ));
			float2 UV141 = panner32;
			float2 panner31 = ( _Time.x * _UV2Animator + ( WorldUV5 * _UV2Tilling ));
			float2 UV240 = panner31;
			float3 lerpResult10 = lerp( UnpackScaleNormal( tex2D( _Normalmap, UV141 ), _Normalmap1strength ) , UnpackScaleNormal( tex2D( _Normalmap, UV240 ), _NormalMap2strength ) , _Normalblendstrength);
			float3 Normalmap19 = lerpResult10;
			o.Normal = Normalmap19;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float fresnelNdotV21 = dot( Normalmap19, ase_worldViewDir );
			float fresnelNode21 = ( 0.0 + 1.0 * pow( 1.0 - fresnelNdotV21, 1.336 ) );
			float4 lerpResult18 = lerp( _Colordeep , _Colorshadow , fresnelNode21);
			float4 color23 = lerpResult18;
			o.Albedo = color23.rgb;
			o.Smoothness = _Glossines;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15700
1320;92;600;926;1688.024;392.5663;1.982543;False;False
Node;AmplifyShaderEditor.RangedFloatNode;58;-797.2668,1282.379;Float;False;Property;_Float1;Float 1;14;0;Create;True;0;0;False;0;7.294117;0;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;57;-493.834,1290.332;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;56;-183.4332,1275.895;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;47;218.2867,1345.356;Float;True;Property;_TextureSample1;Texture Sample 1;11;0;Create;True;0;0;False;0;bcc1fa6a48dfa9441b2fd4a63d9adfbd;bcc1fa6a48dfa9441b2fd4a63d9adfbd;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;48;221.0901,1095.316;Float;True;Property;_TextureSample2;Texture Sample 2;12;0;Create;True;0;0;False;0;bcc1fa6a48dfa9441b2fd4a63d9adfbd;bcc1fa6a48dfa9441b2fd4a63d9adfbd;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;50;646.3226,1163.666;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;55;929.7633,1397.296;Float;False;Property;_Amplitude;Amplitude;13;0;Create;True;0;0;False;0;0;0;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;54;1000.898,1010.005;Float;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;44;-379.8636,-34.20894;Float;False;1250.527;716.7206;UV 1 & 2;12;30;27;32;31;39;34;33;36;38;35;41;40;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;6;-1818.103,-453.2061;Float;False;851.8992;310.739;World UV;5;1;2;3;5;4;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;26;-1830.623,-105.7824;Float;False;1167.015;629.3708;Color;7;16;15;18;22;21;23;46;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;51;875.238,1224.925;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;25;-1748.63,561.9875;Float;False;1285.241;579.3616;Normal Map;10;9;7;11;12;10;19;13;8;42;43;;1,1,1,1;0;0
Node;AmplifyShaderEditor.Vector2Node;38;50.4636,521.5117;Float;False;Property;_UV2Animator;UV 2 Animator;8;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;33;40.56409,113.991;Float;False;Property;_UV1Tilling;UV 1 Tilling;4;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;3;-1355.204,-347.4669;Float;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;43;-1647.646,700.9566;Float;False;40;UV2;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;45;1003.835,503.4459;Float;False;Property;_Glossines;Glossines;10;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;31;417.0308,236.5605;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;39;50.46363,209.5111;Float;False;Property;_UV1Animator;UV 1 Animator;7;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;35;34.86331,427.9113;Float;False;Property;_UV2Tilling;UV 2 Tilling;9;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;34;199.1642,15.79106;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;4;-1549.204,-257.4672;Float;False;Constant;_UVScale;UV Scale;0;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;21;-1511.635,321.5886;Float;True;Standard;WorldNormal;ViewDir;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;16;-1522.701,139.8233;Float;False;Property;_Colorshadow;Color shadow;6;0;Create;True;0;0;False;0;0.3858135,0.7007851,0.9622642,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;23;-906.6085,81.94711;Float;False;color;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;18;-1129.98,52.19916;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;15;-1580.699,-55.78245;Float;False;Property;_Colordeep;Color deep;5;0;Create;True;0;0;False;0;0,0.3584906,0.3344465,0;0,0.3584906,0.3344465,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexturePropertyNode;7;-1687.461,783.4053;Float;True;Property;_Normalmap;Normal map;1;0;Create;True;0;0;False;0;None;b5adeb8f13d463c4da3da690b6e1cd44;True;bump;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.SamplerNode;8;-1320.513,611.9875;Float;True;Property;_NormalMap;Normal Map;1;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TimeNode;30;-329.8636,208.5593;Float;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;27;-297.8191,112.1444;Float;False;5;WorldUV;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;9;-1320.513,817.9876;Float;True;Property;_TextureSample0;Texture Sample 0;3;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;36;216.8634,365.5112;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;24;1043.806,287.2556;Float;False;23;color;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;42;-1643.646,614.9566;Float;False;41;UV1;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;32;409.3644,100.391;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;46;-1725.436,410.5676;Float;False;Constant;_Float0;Float 0;11;0;Create;True;0;0;False;0;1.336;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;19;-706.3886,761.0449;Float;False;Normalmap;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-1273.593,1026.349;Float;False;Property;_Normalblendstrength;Normal blend strength;3;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;22;-1780.623,277.8779;Float;False;19;Normalmap;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;40;617.2634,235.5111;Float;False;UV2;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;20;1023.034,400.5783;Float;False;19;Normalmap;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;52;1239.291,1233.731;Float;False;3;3;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;5;-1209.204,-348.4667;Float;False;WorldUV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;41;627.6638,102.9113;Float;False;UV1;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;2;-1545.204,-359.4669;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;12;-1715.43,1053.92;Float;False;Property;_NormalMap2strength;Normal Map 2 strength;0;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;1;-1768.103,-403.2061;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.LerpOp;10;-918.818,730.2256;Float;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-1718.63,973.5197;Float;False;Property;_Normalmap1strength;Normal map 1 strength;2;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1364.045,307.4301;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;New Amplify Shader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;57;0;58;0
WireConnection;56;0;57;0
WireConnection;47;1;56;0
WireConnection;48;1;56;0
WireConnection;50;0;48;2
WireConnection;50;1;47;2
WireConnection;51;0;50;0
WireConnection;3;0;2;0
WireConnection;3;1;4;0
WireConnection;31;0;36;0
WireConnection;31;2;38;0
WireConnection;31;1;30;1
WireConnection;34;0;27;0
WireConnection;34;1;33;0
WireConnection;21;0;22;0
WireConnection;21;3;46;0
WireConnection;23;0;18;0
WireConnection;18;0;15;0
WireConnection;18;1;16;0
WireConnection;18;2;21;0
WireConnection;8;0;7;0
WireConnection;8;1;42;0
WireConnection;8;5;11;0
WireConnection;9;0;7;0
WireConnection;9;1;43;0
WireConnection;9;5;12;0
WireConnection;36;0;27;0
WireConnection;36;1;35;0
WireConnection;32;0;34;0
WireConnection;32;2;39;0
WireConnection;32;1;30;1
WireConnection;19;0;10;0
WireConnection;40;0;31;0
WireConnection;52;0;51;0
WireConnection;52;1;54;0
WireConnection;52;2;55;0
WireConnection;5;0;3;0
WireConnection;41;0;32;0
WireConnection;2;0;1;1
WireConnection;2;1;1;3
WireConnection;10;0;8;0
WireConnection;10;1;9;0
WireConnection;10;2;13;0
WireConnection;0;0;24;0
WireConnection;0;1;20;0
WireConnection;0;4;45;0
WireConnection;0;11;52;0
ASEEND*/
//CHKSM=3E8A2E841002AA93911F00592EA9D8E67F4EDB13