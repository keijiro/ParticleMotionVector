#include "UnityCG.cginc"

float4x4 _NonJitteredVP;
float4x4 _PreviousVP;
float4x4 _PreviousM;

struct appdata
{
    float4 vertex : POSITION;
    float3 center : TEXCOORD1;
    float3 rotation : TEXCOORD2;
    float3 velocity : TEXCOORD3;
};

struct v2f
{
    float4 vertex : SV_POSITION;
    float4 transfer0 : TEXCOORD0;
    float4 transfer1 : TEXCOORD1;
};

float3x3 EulerToMatrix(float3 v)
{
    float sx, cx;
    float sy, cy;
    float sz, cz;

    sincos(v.x, sx, cx);
    sincos(v.y, sy, cy);
    sincos(v.z, sz, cz);

    return float3x3(
        sx*sy*sz + cy*cz, cx*sz, sx*cy*sz - sy*cz,
        sx*sy*cz - cy*sz, cx*cz, sx*cy*cz + sy*sz,
                   cx*sy,   -sx,            cx*cy
    );
}

v2f vert(appdata v)
{
    float3 vel = v.velocity * unity_DeltaTime.x;
    float4 vp0 = v.vertex - float4(vel, 0);
    float4 vp1 = v.vertex;

    v2f o;
    o.vertex = UnityObjectToClipPos(vp1);
    o.transfer0 = mul(_PreviousVP, mul(_PreviousM, vp0));
    o.transfer1 = mul(_NonJitteredVP, mul(unity_ObjectToWorld, vp1));
    return o;
}

half4 frag(v2f i) : SV_Target
{
    float3 hp0 = i.transfer0.xyz / i.transfer0.w;
    float3 hp1 = i.transfer1.xyz / i.transfer1.w;

    float2 vp0 = (hp0.xy + 1) / 2;
    float2 vp1 = (hp1.xy + 1) / 2;

#if UNITY_UV_STARTS_AT_TOP
    vp0.y = 1 - vp0.y;
    vp1.y = 1 - vp1.y;
#endif

    return half4(vp1 - vp0, 0, 1);
}
