// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Ocean"
{
	Properties
	{
		_EdgeLength ( "Edge length", Range( 2, 50 ) ) = 2
		_WaterFallOff("WaterFallOff", Range( -5 , 5)) = 0
		_Distortion("Distortion", Range( -1 , 1)) = 0
		_WaterDepth("WaterDepth", Range( 0 , 1)) = 0.6270669
		_WaterNormal("Water Normal", 2D) = "bump" {}
		_ShalowColor("ShalowColor", Color) = (0,0.6037736,0.5215474,0)
		_DeepColor("DeepColor", Color) = (0,0.4553242,1,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" }
		Cull Back
		GrabPass{ }
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#include "Tessellation.cginc"
		#pragma target 4.6
		#pragma surface surf Standard alpha:fade keepalpha noshadow vertex:vertexDataFunc tessellate:tessFunction 
		struct Input
		{
			float2 uv_texcoord;
			float4 screenPos;
		};

		uniform sampler2D _WaterNormal;
		uniform float4 _DeepColor;
		uniform float4 _ShalowColor;
		uniform sampler2D _CameraDepthTexture;
		uniform float _WaterDepth;
		uniform float _WaterFallOff;
		uniform sampler2D _GrabTexture;
		uniform float _Distortion;
		uniform float _EdgeLength;


		inline float4 ASE_ComputeGrabScreenPos( float4 pos )
		{
			#if UNITY_UV_STARTS_AT_TOP
			float scale = -1.0;
			#else
			float scale = 1.0;
			#endif
			float4 o = pos;
			o.y = pos.w * 0.5f;
			o.y = ( pos.y - o.y ) * _ProjectionParams.x * scale + o.y;
			return o;
		}


		float4 tessFunction( appdata_full v0, appdata_full v1, appdata_full v2 )
		{
			return UnityEdgeLengthBasedTess (v0.vertex, v1.vertex, v2.vertex, _EdgeLength);
		}

		void vertexDataFunc( inout appdata_full v )
		{
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 panner39 = ( 1.0 * _Time.y * float2( 0.05,0.1 ) + i.uv_texcoord);
			float2 panner40 = ( 1.0 * _Time.y * float2( 0.05,0.02 ) + i.uv_texcoord);
			float3 temp_output_44_0 = BlendNormals( tex2D( _WaterNormal, panner39 ).rgb , UnpackScaleNormal( tex2D( _WaterNormal, panner40 ), 0.1 ) );
			o.Normal = temp_output_44_0;
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float eyeDepth31 = LinearEyeDepth(UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture,UNITY_PROJ_COORD( ase_screenPos ))));
			float temp_output_58_0 = saturate( pow( ( abs( ( eyeDepth31 - ase_screenPos.w ) ) + _WaterDepth ) , _WaterFallOff ) );
			float4 lerpResult36 = lerp( _DeepColor , _ShalowColor , temp_output_58_0);
			float4 ase_grabScreenPos = ASE_ComputeGrabScreenPos( ase_screenPos );
			float2 appendResult47 = (float2(ase_grabScreenPos.r , ase_grabScreenPos.g));
			float4 screenColor45 = tex2D( _GrabTexture, ( float3( ( appendResult47 / ase_grabScreenPos.a ) ,  0.0 ) + ( _Distortion * temp_output_44_0 ) ).xy );
			float4 lerpResult52 = lerp( lerpResult36 , screenColor45 , temp_output_58_0);
			o.Albedo = lerpResult52.rgb;
			o.Occlusion = 1.0;
			o.Alpha = 1;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15700
0;582;1470;436;2728.311;-6.351256;1.963708;True;False
Node;AmplifyShaderEditor.ScreenPosInputsNode;71;-2125.804,292.6425;Float;False;1;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScreenDepthNode;31;-1879.036,249.9214;Float;False;0;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;37;-2539.658,-471.4815;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;43;-1976.624,-201.3206;Float;False;Constant;_Float0;Float 0;4;0;Create;True;0;0;False;0;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;32;-1623.036,361.9211;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;40;-2137.399,-355.3034;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.05,0.02;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;39;-2137.399,-487.3039;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.05,0.1;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.AbsOpNode;75;-1446.191,329.2973;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;55;-1479.036,473.9211;Float;False;Property;_WaterDepth;WaterDepth;7;0;Create;True;0;0;False;0;0.6270669;0.562;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GrabScreenPosition;74;-1792.808,-801.9553;Float;False;1;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;42;-1751.399,-294.3035;Float;True;Property;_WaterNormal;Water Normal;8;0;Create;True;0;0;False;0;dd2fd2df93418444c8e280f1d34deeb5;dd2fd2df93418444c8e280f1d34deeb5;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;41;-1756.399,-506.3039;Float;True;Property;_TextureSample0;Texture Sample 0;8;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Instance;42;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;57;-1191.036,537.9213;Float;False;Property;_WaterFallOff;WaterFallOff;5;0;Create;True;0;0;False;0;0;-0.4;-5;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;54;-1271.036,313.9211;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BlendNormalsNode;44;-1367.183,-389.27;Float;False;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;49;-1314.723,-565.6946;Float;False;Property;_Distortion;Distortion;6;0;Create;True;0;0;False;0;0;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;47;-1391.834,-766.2443;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PowerNode;56;-1143.036,313.9211;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;50;-1043.884,-524.0576;Float;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;48;-1196.723,-715.6946;Float;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ColorNode;34;-978.1768,-48.29391;Float;False;Property;_DeepColor;DeepColor;10;0;Create;True;0;0;False;0;0,0.4553242,1,0;0,0.252639,0.5283019,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;58;-935.0359,201.9214;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;35;-976.1768,-220.2936;Float;False;Property;_ShalowColor;ShalowColor;9;0;Create;True;0;0;False;0;0,0.6037736,0.5215474,0;0,1,1,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;51;-884.12,-670.78;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ScreenColorNode;45;-693.1031,-635.599;Float;False;Global;_GrabScreen0;Grab Screen 0;4;0;Create;True;0;0;False;0;Object;-1;False;False;1;0;FLOAT2;0,0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;36;-546.0861,-23.64227;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;59;-157.5521,14.48766;Float;False;Constant;_Float1;Float 1;7;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;52;-380.0663,-315.4304;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-0.6999996,-134.5;Float;False;True;6;Float;ASEMaterialInspector;0;0;Standard;Ocean;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;True;2;2;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;6;-1;-1;0;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;31;0;71;0
WireConnection;32;0;31;0
WireConnection;32;1;71;4
WireConnection;40;0;37;0
WireConnection;39;0;37;0
WireConnection;75;0;32;0
WireConnection;42;1;40;0
WireConnection;42;5;43;0
WireConnection;41;1;39;0
WireConnection;54;0;75;0
WireConnection;54;1;55;0
WireConnection;44;0;41;0
WireConnection;44;1;42;0
WireConnection;47;0;74;1
WireConnection;47;1;74;2
WireConnection;56;0;54;0
WireConnection;56;1;57;0
WireConnection;50;0;49;0
WireConnection;50;1;44;0
WireConnection;48;0;47;0
WireConnection;48;1;74;4
WireConnection;58;0;56;0
WireConnection;51;0;48;0
WireConnection;51;1;50;0
WireConnection;45;0;51;0
WireConnection;36;0;34;0
WireConnection;36;1;35;0
WireConnection;36;2;58;0
WireConnection;52;0;36;0
WireConnection;52;1;45;0
WireConnection;52;2;58;0
WireConnection;0;0;52;0
WireConnection;0;1;44;0
WireConnection;0;5;59;0
ASEEND*/
//CHKSM=4D00F6CB9F5421467C9C61F0544821CC6EA898A9