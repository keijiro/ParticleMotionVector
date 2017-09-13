#include "UnityCG.cginc"

struct Attributes
{
    float4 position : POSITION;
    float3 normal : NORMAL;
    float4 texcoord0 : TEXCOORD0;
    float4 texcoord1 : TEXCOORD1;
    float4 texcoord2 : TEXCOORD2;
    float2 texcoord3 : TEXCOORD3;
};

float3 GetCenter(Attributes input)
{
    return float3(input.texcoord0.zw, input.texcoord1.x);
}

float3 GetVelocity(Attributes input)
{
    return input.texcoord1.yzw;
}

float3 GetRotation(Attributes input)
{
    return input.texcoord2.xyz;
}

float3 GetRotationSpeed(Attributes input)
{
    return float3(input.texcoord2.w, input.texcoord3.xy);
}

float3x3 EulerToMatrix(float3 v)
{
    float sx, cx;
    float sy, cy;
    float sz, cz;

    sincos(v.x, sx, cx);
    sincos(v.y, sy, cy);
    sincos(v.z, sz, cz);

    return float3x3(
        sx*sy*sz + cy*cz, sx*sy*cz - cy*sz, cx*sy,
                   cx*sz,            cx*cz,   -sx,
        sx*cy*sz - sy*cz, sx*cy*cz + sy*sz, cx*cy
    );
}
