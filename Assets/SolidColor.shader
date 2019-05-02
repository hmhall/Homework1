Shader "Custom/SolidColor"
{
    Properties
    {
        _Color ("Color", Color) = (1, 1, 1, 1)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float3 vertexInWorldCoords : TEXCOORD1;
            };

            float4 _Color;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertexInWorldCoords = mul(unity_ObjectToWorld, v.vertex);
                o.vertex=v.vertex;
                
                if(o.vertexInWorldCoords.y>=1){
                    o.vertex.z+=0.02;
                }
                
                o.vertex = UnityObjectToClipPos(o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
              
                fixed4 col = _Color;

                return col;
            }
            ENDCG
        }
    }
}
