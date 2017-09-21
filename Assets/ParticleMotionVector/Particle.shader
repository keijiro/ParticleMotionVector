// ParticleMotionVector - Example implementation of motion vector writer for
// mesh particle systems | https://github.com/keijiro/ParticleMotionVector

Shader "Particles/Standard Opaque with Motion Vectors"
{
    Properties
    {
        _MainTex("Albedo (RGB)", 2D) = "white" {}
        _Color("Color", Color) = (1,1,1,1)

        [Gamma] _Metallic("Metallic", Range(0, 1)) = 0
        _Glossiness("Smoothness", Range(0, 1)) = 0.5

        _BumpMap("Normal Map", 2D) = "bump" {}
        _BumpScale("Scale", Float) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        Pass
        {
            Tags { "LightMode" = "MotionVectors" }
            ZWrite Off

            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment
            #pragma target 3.5
            #include "Motion.cginc"
            ENDCG
        }

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows addshadow nolightmap
        #pragma target 3.5
        #include "Surface.cginc"
        ENDCG
    }

    FallBack "Diffuse"
}
