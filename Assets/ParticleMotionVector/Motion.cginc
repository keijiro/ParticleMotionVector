#include "Common.cginc"

float4x4 _NonJitteredVP;
float4x4 _PreviousVP;
float4x4 _PreviousM;

struct Varyings
{
    float4 vertex : SV_POSITION;
    float4 transfer0 : TEXCOORD0;
    float4 transfer1 : TEXCOORD1;
};

float3 CalculatePreviousPosition(Attributes input)
{
    float3 vp = input.position.xyz;
    float dt = unity_DeltaTime.x;
    float3 p1 = GetCenter(input);
    float3 p0 = p1 - GetVelocity(input) * dt;
    float3 r1 = GetRotation(input);
    float3 r0 = r1 - GetRotationSpeed(input) * dt;

    vp -= p1;
    vp = mul(transpose(EulerToMatrix(r1)), vp);
    vp = mul(EulerToMatrix(r0), vp);
    vp += p0;

    return vp;
}

Varyings Vertex(Attributes input)
{
    float4 vp0 = float4(CalculatePreviousPosition(input), 1);
    float4 vp1 = input.position;

    Varyings o;
    o.vertex = UnityObjectToClipPos(vp1);
    o.transfer0 = mul(_PreviousVP, mul(_PreviousM, vp0));
    o.transfer1 = mul(_NonJitteredVP, mul(unity_ObjectToWorld, vp1));
    return o;
}

half4 Fragment(Varyings input) : SV_Target
{
    float3 hp0 = input.transfer0.xyz / input.transfer0.w;
    float3 hp1 = input.transfer1.xyz / input.transfer1.w;

    float2 vp0 = (hp0.xy + 1) / 2;
    float2 vp1 = (hp1.xy + 1) / 2;

#if UNITY_UV_STARTS_AT_TOP
    vp0.y = 1 - vp0.y;
    vp1.y = 1 - vp1.y;
#endif

    return half4(vp1 - vp0, 0, 1);
}
