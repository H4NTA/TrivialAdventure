// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Ocean"
{
	Properties
	{
		_EdgeLength ( "Edge length", Range( 2, 50 ) ) = 2
		_WaterFallOff("WaterFallOff", Range( -5 , 1)) = 0
		_Distortion("Distortion", Range( 0 , 1)) = 0
		_Lighting("Lighting", Range( 0 , 1)) = 1
		_WaterDepth("WaterDepth", Range( 0 , 10)) = 0.6270669
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
		uniform sampler2D _GrabTexture;
		uniform float _Distortion;
		uniform sampler2D _CameraDepthTexture;
		uniform float _WaterDepth;
		uniform float _WaterFallOff;
		uniform float _Lighting;
		uniform float _EdgeLength;

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
			float3 temp_output_44_0 = BlendNormals( UnpackNormal( tex2D( _WaterNormal, panner39 ) ) , UnpackScaleNormal( tex2D( _WaterNormal, panner40 ), 0.1 ) );
			o.Normal = temp_output_44_0;
			float4 lerpResult36 = lerp( _DeepColor , _ShalowColor , float4( 0,0,0,0 ));
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float2 appendResult47 = (float2(ase_screenPos.x , ase_screenPos.y));
			float4 screenColor86 = tex2D( _GrabTexture, ( float3( ( appendResult47 / ase_screenPos.w ) ,  0.0 ) + ( _Distortion * temp_output_44_0 ) ).xy );
			float eyeDepth31 = LinearEyeDepth(UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture,UNITY_PROJ_COORD( ase_screenPos ))));
			float4 lerpResult52 = lerp( lerpResult36 , screenColor86 , saturate( pow( ( ( abs( ( eyeDepth31 - ase_screenPos.w ) ) * 0.007 ) + _WaterDepth ) , _WaterFallOff ) ));
			o.Albedo = lerpResult52.rgb;
			o.Occlusion = _Lighting;
			o.Alpha = 1;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15700
386;579;1202;439;3192.452;759.309;2.906892;True;False
Node;AmplifyShaderEditor.ScreenPosInputsNode;71;-2277.473,139.4625;Float;False;1;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScreenDepthNode;31;-1969.856,84.8914;Float;False;0;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;37;-2539.658,-471.4815;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;43;-1976.624,-201.3206;Float;False;Constant;_Float0;Float 0;4;0;Create;True;0;0;False;0;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;78;-1643.509,206.6794;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;39;-2137.399,-487.3039;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.05,0.1;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;40;-2137.399,-355.3034;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.05,0.02;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.AbsOpNode;75;-1491.011,212.2673;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;42;-1751.399,-294.3035;Float;True;Property;_WaterNormal;Water Normal;9;0;Create;True;0;0;False;0;dd2fd2df93418444c8e280f1d34deeb5;dd2fd2df93418444c8e280f1d34deeb5;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;84;-1742.592,-517.2964;Float;True;Property;_TextureSample0;Texture Sample 0;9;0;Create;True;0;0;False;0;dd2fd2df93418444c8e280f1d34deeb5;dd2fd2df93418444c8e280f1d34deeb5;True;0;True;bump;Auto;True;Instance;42;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScreenPosInputsNode;81;-1651.766,-776.3966;Float;False;1;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;79;-1351.771,205.4401;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0.007;False;1;FLOAT;0
Node;AmplifyShaderEditor.BlendNormalsNode;44;-1367.183,-389.27;Float;False;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;55;-1497.036,354.9211;Float;False;Property;_WaterDepth;WaterDepth;8;0;Create;True;0;0;False;0;0.6270669;1.4;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;47;-1391.834,-766.2443;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;49;-1416.121,-589.5842;Float;False;Property;_Distortion;Distortion;6;0;Create;True;0;0;False;0;0;0.02;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;54;-1200.036,209.9211;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;48;-1196.723,-715.6946;Float;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;50;-1130.884,-540.0576;Float;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;57;-1344.036,440.9213;Float;False;Property;_WaterFallOff;WaterFallOff;5;0;Create;True;0;0;False;0;0;-0.94;-5;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;56;-1071.036,204.9211;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;51;-919.12,-618.78;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;35;-976.1768,-220.2936;Float;False;Property;_ShalowColor;ShalowColor;10;0;Create;True;0;0;False;0;0,0.6037736,0.5215474,0;0,1,1,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;34;-978.1768,-48.29391;Float;False;Property;_DeepColor;DeepColor;11;0;Create;True;0;0;False;0;0,0.4553242,1,0;0,0.252639,0.5283019,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;58;-935.0359,201.9214;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;36;-546.0861,-23.64227;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ScreenColorNode;86;-752.0468,-610.4861;Float;False;Global;_GrabScreen0;Grab Screen 0;7;0;Create;True;0;0;False;0;Object;-1;False;False;1;0;FLOAT2;0,0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;52;-304.8663,-244.6302;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;59;-300.5522,32.68766;Float;False;Property;_Lighting;Lighting;7;0;Create;True;0;0;False;0;1;0.781;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-0.6999996,-134.5;Float;False;True;6;Float;ASEMaterialInspector;0;0;Standard;Ocean;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;True;2;2;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;0;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;31;0;71;0
WireConnection;78;0;31;0
WireConnection;78;1;71;4
WireConnection;39;0;37;0
WireConnection;40;0;37;0
WireConnection;75;0;78;0
WireConnection;42;1;40;0
WireConnection;42;5;43;0
WireConnection;84;1;39;0
WireConnection;79;0;75;0
WireConnection;44;0;84;0
WireConnection;44;1;42;0
WireConnection;47;0;81;1
WireConnection;47;1;81;2
WireConnection;54;0;79;0
WireConnection;54;1;55;0
WireConnection;48;0;47;0
WireConnection;48;1;81;4
WireConnection;50;0;49;0
WireConnection;50;1;44;0
WireConnection;56;0;54;0
WireConnection;56;1;57;0
WireConnection;51;0;48;0
WireConnection;51;1;50;0
WireConnection;58;0;56;0
WireConnection;36;0;34;0
WireConnection;36;1;35;0
WireConnection;86;0;51;0
WireConnection;52;0;36;0
WireConnection;52;1;86;0
WireConnection;52;2;58;0
WireConnection;0;0;52;0
WireConnection;0;1;44;0
WireConnection;0;5;59;0
ASEEND*/
//CHKSM=CD43B5C33642C54E15697288BC0D151E7A0AC66D