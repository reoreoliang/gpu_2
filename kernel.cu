// Ĭ����h��ͷ��ʾ�����ϵı�������d��ͷ��ʾ�豸�ϵı���
#include "cuda_runtime.h"
#include <iostream>
#include <cuda.h>


//˫������ӳ���
__global__ void gpu_add(int d_a, int d_b, int* d_c) {
	// �ú������������α���Ϊ���룬�����ӷ��洢�ڵ���������ָ��d_cָ����ڴ�λ��
	// �豸��������ֵΪvoid����Ϊ����������洢��ָ��ָ����ڴ��У���������ʽ�ط����κ�ֵ
	*d_c = d_a + d_b;
}


int main(void) {
	// �������������Դ洢���
	int h_c;
	// �����豸ָ��
	int* d_c;
	// Ϊ�豸ָ������ڴ�
	cudaMalloc((void**)&d_c, sizeof(int));  // �ú�������malloc�������������豸�Ϸ���d_c�������ڴ�
	// ����1��4��Ϊ���벢������洢��d_c���������ں˵���
	// << <1, 1> >> ��ʾִ��1��block��ÿ��blockһ���߳�
	gpu_add << <1, 1 >> > (1, 4, d_c);
	cudaMemcpy(&h_c, d_c, sizeof(int), cudaMemcpyDeviceToHost);
	printf("1 + 4 = %d\n", h_c);
	// �ͷ��豸�ϵ��ڴ�
	cudaFree(d_c);
	return 0;
}