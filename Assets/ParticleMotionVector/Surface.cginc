#include "UnityCG.cginc"

struct Input
{
    float2 uv_MainTex;
    float4 color : COLOR;
};

sampler2D _MainTex;
sampler2D _BumpMap;

fixed4 _Color;
half _Metallic;
half _Glossiness;
half _BumpScale;

void surf(Input IN, inout SurfaceOutputStandard o)
{
    fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
    o.Albedo = IN.color.rgb * c.rgb;
    o.Metallic = _Metallic;
    o.Smoothness = _Glossiness;
    o.Normal = UnpackScaleNormal(tex2D(_BumpMap, IN.uv_MainTex), _BumpScale);
    o.Alpha = c.a;
}
