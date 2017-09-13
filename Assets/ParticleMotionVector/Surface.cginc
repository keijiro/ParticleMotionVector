#include "UnityCG.cginc"

sampler2D _MainTex;

struct Input {
    float2 uv_MainTex;
};

half _Smoothness;
half _Metallic;
fixed4 _Color;

void surf(Input IN, inout SurfaceOutputStandard o)
{
    fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
    o.Albedo = c.rgb;
    o.Metallic = _Metallic;
    o.Smoothness = _Smoothness;
    o.Alpha = c.a;
}
