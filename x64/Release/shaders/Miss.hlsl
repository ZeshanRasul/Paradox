#include "Common.hlsl"

[shader("miss")]
void Miss(inout HitInfo payload)
{
	payload.shadedColourAndHitT = float4(0.2f, 0.2f, 0.2f, -1.f);
}