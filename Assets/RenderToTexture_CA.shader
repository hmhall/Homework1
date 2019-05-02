Shader "Custom/RenderToTexture_CA"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {} 
    }
	SubShader
	{
		Tags { "RenderType" = "Opaque" }
		
		Pass
		{

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"
            
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
   
			v2f vert(appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				return o;
			}
            
           
            sampler2D _MainTex;
            
			fixed4 frag(v2f i) : SV_Target
			{
            
                float2 texel = float2(
                    _MainTex_TexelSize.x, 
                    _MainTex_TexelSize.y 
                );
                
                float cx = i.uv.x;
                float cy = i.uv.y;
                
                float4 C = tex2D( _MainTex, float2( cx, cy ));   
                
                float up = i.uv.y + texel.y * 1;
                float down = i.uv.y + texel.y * -1;
                float right = i.uv.x + texel.x * 1;
                float left = i.uv.x + texel.x * -1;
                
                float4 arr[8];
                
                arr[0] = tex2D(  _MainTex, float2( cx   , up ));   //N
                arr[1] = tex2D(  _MainTex, float2( right, up ));   //NE
                arr[2] = tex2D(  _MainTex, float2( right, cy ));   //E
                arr[3] = tex2D(  _MainTex, float2( right, down )); //SE
                arr[4] = tex2D(  _MainTex, float2( cx   , down )); //S
                arr[5] = tex2D(  _MainTex, float2( left , down )); //SW
                arr[6] = tex2D(  _MainTex, float2( left , cy ));   //W
                arr[7] = tex2D(  _MainTex, float2( left , up ));   //NW

                int cnt = 0;
                int zcnt=0;
                int dir=0;
                for(int i=0;i<8;i++){
                    if (arr[i].g > 0.5) {
                        cnt++;
                    }
                }
                for(int i=0;i<8;i++){
                    if (arr[i].r > 0.5) {
                        zcnt++;
                    }
                }
                        
                if (C.g >= 0.5) { //cell is alive
                    if(cnt<2||zcnt>cnt) {
                        return float4(1.0,0.0,0.0,1.0); //Any live cell with less than 2 neighbors or more zombie than living neighbours becomes a zombie
                    }
                    else if(cnt>3){
                        return float4(0.0,0.0,0.0,1.0);  //Any live cell with 3 or more neighbors dies due to overcrowding
                    }
                    else{
                        return float4(0.0,1.0,0.0,1.0); //All others live
                    }
                }
                else if (C.r>=0.5){ //cell is a zombie
                    if(cnt>zcnt)
                        return (0.0,0.0,0.0,1.0);
                    else
                        return (1.0,0.0,0.0,1.0);
                }
                else { //cell is dead
                    if (cnt == 3) {
                        //Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

                        return float4(0.0,1.0,0.0,1.0);
                    } else {
                        return float4(0.0,0.0,0.0,1.0);

                    }
                }
                
            }

			ENDCG
		}

	}
	FallBack "Diffuse"
}