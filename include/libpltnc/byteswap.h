/*
 * libpltnc - RISC-V library
 *
 * Copyright (C) 2026 krakenlake
 *
 */
#pragma once
#include "libpltnc/types.h"

#ifndef __ASSEMBLER__
	u64 swap32(u64 val);
	u64 swap64(u64 val);
	u64 has_zero_byte(u64 val);
#endif
