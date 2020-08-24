// 默认以h开头表示主机上的变量，以d开头表示设备上的变量
#include "cuda_runtime.h"
#include <iostream>
#include <cuda.h>


//双变量相加程序
__global__ void gpu_add(int d_a, int d_b, int* d_c) {
	// 该函数以两个整形变量为输入，并将加法存储在第三个整数指针d_c指向的内存位置
	// 设备函数返回值为void，因为它将结果过存储在指针指向的内存中，而不是显式地返回任何值
	*d_c = d_a + d_b;
}


int main(void) {
	// 定义主机变量以存储结果
	int h_c;
	// 定义设备指针
	int* d_c;
	// 为设备指针分配内存
	cudaMalloc((void**)&d_c, sizeof(int));  // 该函数类似malloc函数，用于在设备上分配d_c变量的内存
	// 传递1和4作为输入并将结果存储在d_c中来进行内核调用
	// << <1, 1> >> 表示执行1个block，每个block一个线程
	gpu_add << <1, 1 >> > (1, 4, d_c);
	cudaMemcpy(&h_c, d_c, sizeof(int), cudaMemcpyDeviceToHost);
	printf("1 + 4 = %d\n", h_c);
	// 释放设备上的内存
	cudaFree(d_c);
	return 0;
}