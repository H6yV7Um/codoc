package util

/*
#include "util.h"
#include <stdlib.h>
*/
import "C"

//使用自定义的函数
func GoSum(a, b int) int {
	return int(C.sum(C.int(a), C.int(b)))
}

//使用c的库函数
func Rand() uint64 {
	return uint64(C.rand())
}
