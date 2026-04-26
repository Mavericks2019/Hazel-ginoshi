workspace "Hazel"
	architecture "x64"
	startproject "Hazelinut"

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
IncludeDir["ImGui"] = "vendor/imgui"
IncludeDir["glm"] = "vendor/glm"
IncludeDir["stb_image"] = "vendor/stb_image"
IncludeDir["entt"] = "vendor/entt/include"

include "vendor/GLFW"
include "vendor/Glad"
include "vendor/imgui"

project "Hazel"
	
	kind "StaticLib"
	language "C++"
	staticruntime "on"

	targetdir("bin/" .. outputdir .. "/%{prj.name}")
	objdir("bin-int/" .. outputdir .. "/%{prj.name}")

	pchheader "hzpch.h"
	pchsource "src/hzpch.cpp"

	files
	{
		"src/**.h",
		"src/**.cpp",
		"vendor/glm/glm/**.hpp",
		"vendor/glm/glm/**.inl",
		"vendor/stb_image/**.cpp",
		"vendor/stb_image/**.h",

	}

	includedirs
	{
		"vendor/spdlog-1.2.1/include",
		"src",
		"%{IncludeDir.GLFW}",
		"%{IncludeDir.Glad}",
		"%{IncludeDir.ImGui}",
		"%{IncludeDir.glm}",
		"%{IncludeDir.stb_image}",
		"%{IncludeDir.entt}"

	}
	links
	{
		"GLFW",
		"Glad",
		"ImGui",
		"opengl32.lib"
	}

	filter "system:windows"
		cppdialect "C++17"
		staticruntime "on"
		systemversion "latest"

		defines
		{
			"HZ_PLATFORM_WINDOWS",
			"HZ_BUILD_DLL",
			"GLFW_INCLUDE_NONE",
			"_CRT_SECURE_NO_WARNINGS",
			"_SILENCE_STDEXT_ARR_ITERS_DEPRECATION_WARNING",
			"HZ_PROFILE=1"

		}

		--postbuildcommands
		--{
		--	 "xcopy /Y /I \"bin\\" .. outputdir .. "\\Hazel\\Hazel.lib\" \"bin\\" .. outputdir .. "\\Sandox\\\""

		--}

	filter "configurations:Debug"
		defines "HZ_DEBUG"
		symbols "on"
		runtime "Debug"
		buildoptions { "/utf-8"}


	filter "configurations:Release"
		defines "HZ_RELEASE"
		symbols "on"
		runtime "Release"
		optimize "Full"
		buildoptions {"/utf-8",}


	filter "configurations:Dist"
		defines "HZ_DIST"
		symbols "on"
		runtime "Release"
		optimize "Full"
		buildoptions {"/utf-8"}


project "Sandox"
	location "Sandox"
	kind "ConsoleApp"
	language "C++"
	cppdialect "C++17"
	staticruntime "on"

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
		"src",
		"%{IncludeDir.glm}",
		"%{IncludeDir.ImGui}",
		"%{IncludeDir.entt}"
	}

	links
	{
		"Hazel"
	}

	filter "system:windows"
		staticruntime "on"
		systemversion "latest"

		defines
		{
			"HZ_PLATFORM_WINDOWS",
			"_SILENCE_STDEXT_ARR_ITERS_DEPRECATION_WARNING",
			"HZ_PROFILE=1"
		}

		postbuildcommands { 'xcopy /Y /I /E "%{prj.location}/assets" "%{cfg.targetdir}/assets"' }



    filter "configurations:Debug"
        defines "HZ_DEBUG"
        symbols "on"
        runtime "Debug"
        buildoptions {"/utf-8"}

    filter "configurations:Release"
        defines "HZ_RELEASE"
        symbols "on"
        runtime "Release"
		optimize "Full"
        buildoptions {"/utf-8"}

    filter "configurations:Dist"
        defines "HZ_DIST"
        symbols "on"
        runtime "Release"
		optimize "Full"
        buildoptions {"/utf-8"}

    filter {"system:windows","configurations:Release"}
        buildoptions {"/utf-8"}


project "Hazelinput"
	location "Hazelinput"
	kind "ConsoleApp"
	language "C++"
	cppdialect "C++17"
	staticruntime "on"

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
		"src",
		"%{IncludeDir.glm}",
		"%{IncludeDir.ImGui}",
		"%{IncludeDir.entt}"
	}

	links
	{
		"Hazel"
	}

	filter "system:windows"
		systemversion "latest"
		defines
		{
			"HZ_PLATFORM_WINDOWS",
			"_SILENCE_STDEXT_ARR_ITERS_DEPRECATION_WARNING",
			"HZ_PROFILE=1"
		}

		postbuildcommands { 'xcopy /Y /I /E "%{prj.location}/assets" "%{cfg.targetdir}/assets"' }
		
	filter "configurations:Debug"
		defines "HZ_DEBUG"
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		defines "HZ_RELEASE"
		runtime "Release"
		optimize "on"

	filter "configurations:Dist"
		defines "HZ_DIST"
		runtime "Release"
		optimize "on"