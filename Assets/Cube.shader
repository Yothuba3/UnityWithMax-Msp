Shader "Unlit/Cube"
{
    Properties
    {
    _Color ("Color", Color) = (0.3,0.6,1.0,1.0)
    _SecondColor("SecondColor",Color) = (0.6, 0.4, 1.0, 1.0)
    _Power("Power",Float) = 1.0
    _Size("size", Float) = 1.0
    _TimeFactor("TimeFactor", Float) = 1.0
    _SecondTimeFactor("2つ目の円の回転の速さ",Float) = 1.0
    _RadSize("円の大きさ", Float) = 1.0
    _SecondRadSize("２つめの円の大きさ",Float) = 0.5

    }
    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue" = "Transparent"}
        LOD 100
        Cull Off
        Blend SrcAlpha One
        ZWrite Off

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma geometry geom
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                float3 normal:NORMAL;
            };

            struct v2g
            {
                float4 vertex:POSITION;
                float2 uv : TEXCOORD0;
                float3 normal:NORMAL;
            };

            struct g2f
            {
                float4 vertex:SV_POSITION;
                float2 uv:TEXCOORD0;
                float3 color : TEXCOORD1;

            };

            float4 _Color;
            float _Power;
            float _Size;
            float _TimeFactor;
            float _RadSize;
            float _SecondRadSize;

            float rand(float2 co){
				return frac(sin(dot(co.xy, float2(12.9898,78.233))) * 43758.5453);
			}

            v2g vert(appdata v)
            {
                v2g o;
                o.vertex = v.vertex;
                o.uv = v.uv.xy;
                o.normal = v.normal;
                return o;
            }

            [maxvertexcount(4)]
            void geom(triangle v2g IN[3], inout TriangleStream<g2f> stream){

                //float angle = IN[0].vertex.y * 4.0 + (degrees(_Time.y%1)/10);
                //float angle = _Time * rand(IN[0].vertex.xz) * rand(IN[0].vertex.yx) * _TimeFactor;
                float angle = _Time * _TimeFactor;
                float2x2 rotateM = float2x2(cos(angle), -sin(angle), sin(angle),cos(angle));

                float3 normal = normalize(cross((IN[2].vertex - IN[0].vertex), (IN[1].vertex - IN[0].vertex)));
				g2f o;
				o.color = _Color;
				float3 pos = IN[0].vertex;
				pos += normal * _RadSize;
				pos.xz = mul(rotateM,pos.xz);
				pos.zy = mul(rotateM, pos.zy);
				//pos.xy = mul(rotateM, pos.xy);


                //ビルボード関連
				float4 vp1 = UnityObjectToClipPos(float4(pos, 1));
                float aspectRatio = - UNITY_MATRIX_P[0][0] / UNITY_MATRIX_P[1][1];
                float sz = 0.002 * _Size;
				//UV座標系はアスペクト比を考慮していないので、アスペクト比を乗算することで補正をしている
				o.uv = float2(-1,-1);
				o.vertex = vp1+sz *float4(1 * aspectRatio,1,0,0);
				stream.Append(o);
				o.uv = float2(-1,1);
				o.vertex = vp1+sz * float4(1* aspectRatio,-1,0,0);
				stream.Append(o);
				o.uv = float2(1,-1);
				o.vertex = vp1+sz * float4(-1* aspectRatio,1,0,0);
				stream.Append(o);
				o.uv = float2(1,1);
				o.vertex = vp1+sz * float4(-1* aspectRatio,-1,0,0);
				stream.Append(o);
				stream.RestartStrip();

            }


            fixed4 frag (g2f i) : SV_Target
            {
             float l = length(i.uv);
				clip(1-l);
				float3 color = i.color;

				color *= pow(max(0, 0.5) + 1 - l, 0.5) * 2;
				color = min(1, color);
				color = pow(color, 2.2);

				return float4(color,smoothstep(1,0.8,l)*_Color.a);


            }
            ENDCG
        }
    }
}
