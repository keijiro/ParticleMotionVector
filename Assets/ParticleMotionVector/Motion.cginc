#include "Common.cginc"

float4x4 _NonJitteredVP;
float4x4 _PreviousVP;

struct Varyings
{
    float4 vertex : SV_POSITION;
    float4 transfer0 : TEXCOORD0;
    float4 transfer1 : TEXCOORD1;
};

float3 CalculatePreviousPosition(Attributes input)
{
    float dt = unity_DeltaTime.x;

    // Current rotation
    float3 r1 = GetRotation(input);

    // Inverse current rotation matrix
    float3x3 imr1 = transpose(Euler3x3(r1));

    // Previous rotation matrix
    float3x3 mr0 = Euler3x3(r1 - GetRotationSpeed(input) * dt);

    // Current center position
    float3 p1 = GetCenter(input);

    // Previous center position
    float3 p0 = p1 - mul(imr1, GetVelocity(input)) * dt;

    // Take back to the origin, apply the inverse rotation, then reapply the
    // previous rotation and position.
    return mul(mr0, mul(imr1, input.position.xyz - p1)) + p0;
}

Varyings Vertex(Attributes input)
{
    float4 vp0 = float4(CalculatePreviousPosition(input), 1);
    float4 vp1 = input.position;

    Varyings o;
    o.vertex = UnityObjectToClipPos(vp1);
    o.transfer0 = mul(_PreviousVP, vp0);
    o.transfer1 = mul(_NonJitteredVP, vp1);
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
