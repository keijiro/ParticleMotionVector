// ParticleMotionVector - Example implementation of motion vector writer for
// mesh particle systems | https://github.com/keijiro/ParticleMotionVector

#include "UnityCG.cginc"

struct CustomAttributes
{
    float4 position : POSITION;
    float4 texcoord0 : TEXCOORD0;   // uv.xy, center.xy
    float4 texcoord1 : TEXCOORD1;   // center.z, velocity.xyz
    float4 texcoord2 : TEXCOORD2;   // rotation.xyz, rotationspeed.x
    float2 texcoord3 : TEXCOORD3;   // rotationspeed.yz
};

float3 GetCenter(CustomAttributes input)
{
    return float3(input.texcoord0.zw, input.texcoord1.x);
}

float3 GetVelocity(CustomAttributes input)
{
    return input.texcoord1.yzw;
}

float3 GetRotation(CustomAttributes input)
{
    return input.texcoord2.xyz;
}

float3 GetRotationSpeed(CustomAttributes input)
{
    return float3(input.texcoord2.w, input.texcoord3.xy);
}

float3x3 Euler3x3(float3 v)
{
    float sx, cx;
    float sy, cy;
    float sz, cz;

    sincos(v.x, sx, cx);
    sincos(v.y, sy, cy);
    sincos(v.z, sz, cz);

    float3 row1 = float3(sx*sy*sz + cy*cz, sx*sy*cz - cy*sz, cx*sy);
    float3 row3 = float3(sx*cy*sz - sy*cz, sx*cy*cz + sy*sz, cx*cy);
    float3 row2 = float3(cx*sz, cx*cz, -sx);

    return float3x3(row1, row2, row3);
}
