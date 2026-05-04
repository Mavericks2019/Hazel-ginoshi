#pragma once

// Platform detection using predefined compiler macros
#if defined(_WIN32) || defined(_WIN64)
	#ifndef HZ_PLATFORM_WINDOWS
		#define HZ_PLATFORM_WINDOWS
	#endif
#elif defined(__APPLE__) || defined(__MACH__)
	#ifndef HZ_PLATFORM_MACOS
		#define HZ_PLATFORM_MACOS
	#endif
#elif defined(__linux__)
	#ifndef HZ_PLATFORM_LINUX
		#define HZ_PLATFORM_LINUX
	#endif
#else
	#error Unknown platform!
#endif
