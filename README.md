ParticleMotionVector
====================

This is an example that shows how to support rendering motion vectors within
the standard particle system of Unity.

Particles/Standard Opaque with Motion Vectors
---------------------------------------------

![inspector](https://i.imgur.com/oxBt0mp.png)

This shader only supports rendering mesh particles without transparency. It may
not sound very useful for particle effects in a general sense, but actually
useful in some specific cases, like when rendering many small moving objects
(asteroids, confetti, etc.) by using a particle system.

![movec](https://i.imgur.com/tFs7Rnjm.png)
![gif](https://i.imgur.com/2dSeftZ.gif)

When using this shader, "Simulation Space" in the main module and "Render
Alignment" in the renderer module have to be set to "World". This is needed to
calculate rotations correctly in the motion vector writer.

![inspector](https://i.imgur.com/QxZIZrE.png)

Also the custom vertex streams have to be set up in the following order:

- UV (TEXCOORD0.xy)
- Center (TEXCOORD0.zw|x)
- Velocity (TEXCOORD1.yzw)
- Rotation3D (TEXCOORD2.xyz)
- RotationSpeed3D (TEXCOORD2.w|xy)

![vertex streams](https://i.imgur.com/BuKy5i7.png)

System requirements
-------------------

- Unity 2017.1 or later

Current limitations
-------------------

In the current implementation, change of the particle size is ignored in the
calculation of motion vectors. This may introduce artifacts when animating the
particle size with using the "Size over Lifetime" module or the "Size by Speed"
module.

How about transparency?
-----------------------

I haven't tried transparency with motion vectors because I think it works only
if someone tweaks it very carefully (and I have no time to invest in it). I
won't recommend it, but you can try it anyway.

License
-------

Copyright (c) 2017 Unity Technologies

This repository is to be treated as an example content of Unity; you can use
the code freely in your projects. Also see the [FAQ] about example contents.

[FAQ]: https://unity3d.com/unity/faq#faq-37863
