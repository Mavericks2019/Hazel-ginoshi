workspace "Hazel"
	architecture "x64"
	startproject "Hazelinput"

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
IncludeDir["yaml_cpp"] = "vendor/yaml-cpp/include"
IncludeDir["ImGuizmo"] = "vendor/ImGuizmo"

include "vendor/GLFW"
include "vendor/Glad"
include "vendor/imgui"
include "vendor/yaml-cpp"

project "Hazel"
	kind "StaticLib"
	language "C++"

	targetdir("%{wks.location}/bin/" .. outputdir .. "/%{prj.name}")
	objdir("%{wks.location}/bin-int/" .. outputdir .. "/%{prj.name}")

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
		"vendor/ImGuizmo/ImGuizmo.h",
		"vendor/ImGuizmo/ImGuizmo.cpp"
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
		"%{IncludeDir.entt}",
		"%{IncludeDir.yaml_cpp}",
		"%{IncludeDir.ImGuizmo}"
	}

	links
	{
		"GLFW",
		"Glad",
		"ImGui",
		"yaml-cpp",
		"opengl32.lib"
	}

	filter "files:vendor/ImGuizmo/**.cpp"
	flags { "NoPCH" }

	filter "system:windows"
		cppdialect "C++17"
		staticruntime "on"
		systemversion "latest"

		defines
		{
			"HZ_PLATFORM_WINDOWS",
			"GLFW_INCLUDE_NONE",
			"YAML_CPP_STATIC_DEFINE",
			"_CRT_SECURE_NO_WARNINGS",
			"_SILENCE_STDEXT_ARR_ITERS_DEPRECATION_WARNING"
		}

	filter "configurations:Debug"
		defines { "HZ_DEBUG", "HZ_ENABLE_ASSERTS" }
		symbols "on"
		buildoptions { "/utf-8" }

	filter "configurations:Release"
		defines "HZ_RELEASE"
		optimize "on"
		buildoptions { "/utf-8" }

	filter "configurations:Dist"
		defines "HZ_DIST"
		optimize "on"
		buildoptions { "/utf-8" }

include "Sandox"
include "Hazelinput"
