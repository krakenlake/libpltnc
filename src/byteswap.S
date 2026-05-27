/*
 * libpltnc - RISC-V library
 *
 * Copyright (C) 2026 krakenlake
 *
 */
#include "config.h"

.global swap32
.global swap64

.text


# swap 4 lower bytes in register: BIG_ENDIAN <---> LOW_ENDIAN
# in: a0
# out: a0 (64 bit sign extended)
.type swap32, @function
swap32:
	mv		a1, zero			# init result
	# byte 0
	li		t1, 0xff			# init AND mask
	srli	t0, a0, 24			# shift byte 3 -> byte 0
	and		a1, t0, t1			# collect result in a1
	# byte 1
	slli	t1, t1, 8			# move AND mask one byte left
	srli	t0, a0, 8			# shift byte 2 -> byte 1
	and		t2, t0, t1			
	or		a1, a1, t2			# collect result in a1
	# byte 2
	slli	t1, t1, 8			# move AND mask one byte left
	slli	t0, a0, 8			# shift byte 1 -> byte 2
	and		t2, t0, t1
	or		a1, a1, t2			# collect result in a1
	# byte 3
	slli	t1, t1, 8			# move AND mask one byte left
	slli	t0, a0, 24			# shift byte 0 -> byte 3
	and		t2, t0, t1
	#or		a0, a1, t2			# final return register is a0
	addw	a0, a1, t2			# use addw instead of or to get sign extension
	ret
.size swap32, .-swap32


# swap 8 bytes in register: BIG_ENDIAN <---> LOW_ENDIAN
# in: a0
# out: a0
.type swap64, @function
swap64:
	mv		a1, zero			# init result
	# byte 0
	li		t1, 0xff			# init AND mask
	srli	t0, a0, 56			# shift byte 7 -> byte 0
	and		a1, t0, t1			# collect result in a1
	# byte 1
	slli	t1, t1, 8			# move AND mask one byte left
	srli	t0, a0, 40			# shift byte 6 -> byte 1
	and		t2, t0, t1			
	or		a1, a1, t2			# collect result in a1
	# byte 2
	slli	t1, t1, 8			# move AND mask one byte left
	srli	t0, a0, 24			# shift byte 5 -> byte 2
	and		t2, t0, t1
	or		a1, a1, t2			# collect result in a1
	# byte 3
	slli	t1, t1, 8			# move AND mask one byte left
	srli	t0, a0, 8			# shift byte 4 -> byte 3
	and		t2, t0, t1
	or		a1, a1, t2			# collect result in a1
	# byte 4
	slli	t1, t1, 8			# move AND mask one byte left
	slli	t0, a0, 8			# shift byte 3 -> byte 4
	and		t2, t0, t1
	or		a1, a1, t2			# collect result in a1
	# byte 5
	slli	t1, t1, 8			# move AND mask one byte left
	slli	t0, a0, 24			# shift byte 2 -> byte 5
	and		t2, t0, t1
	or		a1, a1, t2			# collect result in a1
	# byte 6
	slli	t1, t1, 8			# move AND mask one byte left
	slli	t0, a0, 40			# shift byte 1 -> byte 6
	and		t2, t0, t1
	or		a1, a1, t2			# collect result in a1
	# byte 7
	slli	t1, t1, 8			# move AND mask one byte left
	slli	t0, a0, 56			# shift byte 0 -> byte 7
	and		t2, t0, t1
	or		a0, a1, t2			# final return register is a0
	ret
.size swap64, .-swap64
