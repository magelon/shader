// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Unlit/cosmosJerry"
{
	Properties {
        _MainTex ("Base (RGB)",2D) = "white" {}
        _Zoom ("Zoom", Range(0.5, 20)) = 1
        _Speed ("Speed", Range(0.01, 10)) = 1
    }
    SubShader {
        Pass {
            Tags { "RenderType"="Opaque" "Queue" = "Overlay+2147479647" }
            Cull Off
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
           
            sampler2D _MainTex;
            half _Zoom;
            half _Speed;

            
            struct v2f {
                float4 pos : SV_POSITION;
                half2 uv : TEXCOORD0;
            };
 
            v2f vert(appdata_base v) {
                v2f o;
                v.vertex.x += sign(v.vertex.x) * sin(_Time.w)/20;
                v.vertex.y += sign(v.vertex.y) * cos(_Time.w)/20;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.texcoord;
                return o;
            }
 
 
            fixed4 frag (float4 i : VPOS) : SV_Target
            {
                return tex2D(_MainTex, float2((i.xy/ _ScreenParams.xy) + float2(_CosTime.x * _Speed, _SinTime.x * _Speed) / _Zoom));
            }
            
            half4 frag2(v2f i) : COLOR {
                half4 c = tex2D(_MainTex, i.uv);
                return c;
            }
           
 
            ENDCG
        }
    }
    FallBack "Diffuse"
}
