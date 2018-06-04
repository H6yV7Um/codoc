package main

// #cgo LDFLAGS: -L . -lc_test -lstdc++
// #cgo CFLAGS: -I ./
// #include "foo.h"
import "C"

func main() {

	C.test()

}
