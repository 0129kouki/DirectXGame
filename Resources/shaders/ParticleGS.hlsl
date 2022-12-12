#include "Particle.hlsli"

//struct GSOutput
//{
//	float4 pos : SV_POSITION;
//};
//�O�p�`�̓��͂���A�O�p�`��2�o��

//�l�p�`�̒��_��
static const uint vnum = 4;
//�Z���^�[����̃I�t�Z�b�g
static const float4 offset_array[vnum] =
{
	float4(-0.5f,-0.5f,0,0),
	float4(-0.5f,+0.5f,0,0),
	float4(+0.5f,-0.5f,0,0),
	float4(+0.5f,+0.5f,0,0),
};

//���オ0.0�E�オ1.1
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
	//4�_����
	for (uint i = 0; i < vnum; i++)
	{
		//���S����I�t�Z�b�g���r���{�[�h��]
		float4 offset = mul(matBillboard, offset_array[i]);
		//�I�t�Z�b�g�����炷
		element.svpos = input[0].pos + offset;
		//���[���h���W�x�[�X�ŁA���炷
		element.svpos = input[0].pos + offset_array[i];
		//�r���[�A�ˉe�ϊ�
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
