ParticleMotionVector
--------------------

This is an example that shows how to add motion vector support to a standard
particle shader in Unity.

**"Particles/Standard Opaque with Motion Vectors"**

![inspector](https://i.imgur.com/oxBt0mp.png)

This shader only can be used to render mesh particles without transparency. It
may not sound very useful for particle effects in a general sense, but useful
in some specific cases, like when rendering many small moving objects
(asteroids, confetti, etc.) with using a particle renderer.

![screenshot](https://i.imgur.com/kVyOjuCm.png)

When using this shader, "Simulation Space" in the main module and "Render
Alignment" in the renderer module should be set to "World". This is needed to
calculate rotations correctly in the motion vector writer.

![inspector](https://i.imgur.com/QxZIZrE.png)

Also the custom vertex streams have to be set up in the following order:

- UV (TEXCOORD0.xy)
- Center (TEXCOORD0.zw|x)
- Velocity (TEXCOORD1.yzw)
- Rotation3D (TEXCOORD2.xyz)
- RotationSpeed3D (TEXCOORD2.w|xy)

![vertex streams](https://i.imgur.com/BuKy5i7.png)

Current limitations
-------------------

In the current implementation, animation of the particle size is not handled in
the motion vector writer. This may introduce artifacts when animating the
particle size with using the "Size over Lifetime" module or the "Size by Speed"
module.

How about transparency?
-----------------------

I didn't tried a transparent particle shader with motion vectors, because
personally I think it never works. Although I've never tried it yet, but it
possibly work with motion blur effects.

License
-------

Public domain.
