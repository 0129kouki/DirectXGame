#include "Particle.hlsli"

//struct GSOutput
//{
//	float4 pos : SV_POSITION;
//};
//三角形の入力から、三角形を2つ出力

//四角形の頂点数
static const uint vnum = 4;
//センターからのオフセット
static const float4 offset_array[vnum] =
{
	float4(-0.5f,-0.5f,0,0),
	float4(-0.5f,+0.5f,0,0),
	float4(+0.5f,-0.5f,0,0),
	float4(+0.5f,+0.5f,0,0),
};

//左上が0.0右上が1.1
static const float2 uv_array[vnum] =
{
	float2(0,1),
	float2(0,0),
	float2(1,1),
	float2(1,0),
};

[maxvertexcount(vnum)]
void main(
	point VSOutput input[1]:SV_POSITION,
	inout TriangleStream<GSOutput>output
)
{
	GSOutput element;
	//4点分回す
	for (uint i = 0; i < vnum; i++)
	{
		//中心からオフセットをビルボード回転
		float4 offset = mul(matBillboard, offset_array[i]);
		//オフセット分ずらす
		element.svpos = input[0].pos + offset;
		//ワールド座標ベースで、ずらす
		element.svpos = input[0].pos + offset_array[i];
		//ビュー、射影変換
		element.svpos = mul(mat, element.svpos);
		element.uv = uv_array[i];
		output.Append(element);
	}
}
//[maxvertexcount(vnum)]
//void main(
//	point VSOutput input[1]:SV_POSITION,
//	inout TriangleStream<GSOutput>output
//)

