/**/

struct DirectionalLight
{
	float3			 directionalLightDirection;
	float			 directionalLightPadding;
	float3			 directionalLightColour;
	float			 directionalLightPadding1;
};

struct PointLight
{
	float3			 pointLightPosition;
	float			 pointLightPadding;
	float3			 pointLightColour;
	float			 pointLightPadding1;
};

cbuffer SceneCB : register(b0)
{
	matrix			 view;
	float4			 viewOriginAndTanHalfFovY;
	float2			 resolution;
	float			 numDirLights;
	float			 numPointLights;
	float3			 randomSeedVector0;
	float			 padding;
	float3			 randomSeedVector1;
	float			 padding1;
	DirectionalLight directionalLights[10];
	PointLight		 pointLights[10];
}

cbuffer MaterialCB : register(b1)
{
	float3			 ambient;
	float			 shininess;
	float3			 diffuse;
	float			 ior;
	float3			 specular;
	float			 dissolve;
	float3			 transmittance;
	float			 roughness;
	float3			 emission;
	float			 metallic;
	float4			 textureResolution;
	float			 sheen;
	int				 useTex;
}

struct VSInput
{
	float3 Pos : POSITION;
	float2 TexC : TEXCOORD;
	float3 Normal : NORMAL;
};

struct VSOutput
{
	float4 Pos  : SV_POSITION;
	float3 PosW : POSITION;
	float2 TexC : TEXCOORD;
	float3 NormalW : NORMAL;
};

VSOutput main(VSInput vsInput)
{
	VSOutput vso;
	vso.Pos = mul(float4(vsInput.Pos, 1.0f), view);
	vso.PosW = mul(vsInput.Pos, (float3x3)view);
	vso.TexC = vsInput.TexC;
	vso.NormalW = mul(vsInput.Normal, (float3x3)view);

	return vso;
}