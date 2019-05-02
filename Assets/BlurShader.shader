Shader "Custom/BlurShader"
{
    Properties
    {
        _MainTex ("Main Tex", 2D) = "white" {}
        _Blur ("Blur", int)=0
    }
    SubShader
    {
        Pass{
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            
            sampler2D _MainTex;
            uniform float4 _MainTex_TexelSize;

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv: TEXCOORD0;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float2 uv: TEXCOORD0;
            };
            
            v2f vert (appdata v)
            {
                v2f o;
                o.vertex=v.vertex;
                o.vertex = UnityObjectToClipPos(o.vertex);
                o.uv = v.uv;
                return o;
            }
            
            int _Blur;
            
            fixed4 frag (v2f i) : SV_Target
            {
                //i.uv.x+=_MainTex_TexelSize.x*_Blur;
                float3 avg = 0.0;
                
                int texelsSampled=0;
                for (int xi=-_Blur; xi<=_Blur; xi++){
                    for (int xz=-_Blur; xz<=_Blur;xz++){
                        avg+=tex2D(_MainTex, float2(i.uv.x+_MainTex_TexelSize.x*xi, i.uv.y+_MainTex_TexelSize.y*xz)).rgb;
                        texelsSampled++;
                    }
                }
                avg.x/=texelsSampled;
                avg.y/=texelsSampled;
                avg.z/=texelsSampled;
 //               col+=tex2D(_MainTex, i.uv+_MainTex_TexelSize.y);
                
                return float4(avg,1.0);
            }
        
            ENDCG
        }
    }
}
