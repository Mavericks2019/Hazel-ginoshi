workspace "Hazel"
	architecture "x64"

	configurations
	{
		"Debug",
		"Release",
		"Dist"
	}

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

-- include directories
IncludeDir = {}
IncludeDir["GLFW"] = "vendor/GLFW/include"
IncludeDir["Glad"] = "vendor/Glad/include"

include "vendor/GLFW"
include "vendor/Glad"

project "Hazel"
	
	kind "SharedLib"
	language "C++"

	targetdir("bin/" .. outputdir .. "/%{prj.name}")
	objdir("bin-int/" .. outputdir .. "/%{prj.name}")

	pchheader "hzpch.h"
	pchsource "src/hzpch.cpp"

	files
	{
		"src/**.h",
		"src/**.cpp",
	}

	includedirs
	{
		"vendor/spdlog-1.2.1/include",
		"src",
		"%{IncludeDir.GLFW}",
		"%{IncludeDir.Glad}"

	}
	links
	{
		"GLFW",
		"Glad",
		"opengl32.lib"
	}

	filter "system:windows"
		cppdialect "C++17"
		staticruntime "On"
		systemversion "latest"

		defines
		{
			"HZ_PLATFORM_WINDOWS",
			"HZ_BUILD_DLL",
			"GLFW_INCLUDE_NONE"

		}
		postbuildcommands
		{
			 "xcopy /Y /I \"bin\\" .. outputdir .. "\\Hazel\\Hazel.dll\" \"bin\\" .. outputdir .. "\\Sandox\\\""

		}

	filter "configurations:Debug"
		defines "HZ_DEBUG"
		symbols "On"
		buildoptions { "/utf-8","/MDd" }


	filter "configurations:Release"
		defines "HZ_RELEASE"
		symbols "On"
		buildoptions {"/utf-8","/MD"}


	filter "configurations:Dist"
		defines "HZ_DIST"
		symbols "On"
		buildoptions {"/utf-8","/MD"}


	filter {"system:windows","configurations:Release"}
		buildoptions {"/utf-8","/MD"}


project "Sandox"
	location "Sandox"
	kind "ConsoleApp"
	language "C++"

	targetdir("bin/" .. outputdir .. "/%{prj.name}")
	objdir("bin-int/" .. outputdir .. "/%{prj.name}")

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp",
	}

	includedirs
	{
		"vendor/spdlog-1.2.1/include",
		"src"
	}

	links
	{
		"Hazel"
	}

	filter "system:windows"
		cppdialect "C++17"
		staticruntime "On"
		systemversion "latest"

		defines
		{
			"HZ_PLATFORM_WINDOWS",
		}


	filter "configurations:Debug"
		defines "HZ_DEBUG"
		symbols "On"
		buildoptions {"/utf-8","/MDd"}

	filter "configurations:Release"
		defines "HZ_RELEASE"
		symbols "On"
		buildoptions {"/utf-8","/MD"}

	filter "configurations:Dist"
		defines "HZ_DIST"
		symbols "On"
		buildoptions {"/utf-8","/MD"}

	filter {"system:windows","configurations:Release"}
		buildoptions {"/utf-8","/MD"}
