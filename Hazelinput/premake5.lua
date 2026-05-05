project "Hazelinput"
	kind "ConsoleApp"
	language "C++"
	cppdialect "C++17"
	staticruntime "on"

	targetdir("%{wks.location}/bin/" .. outputdir .. "/%{prj.name}")
	objdir("%{wks.location}/bin-int/" .. outputdir .. "/%{prj.name}")

	files
	{
		"src/**.h",
		"src/**.cpp"
	}

	includedirs
	{
		"%{wks.location}/vendor/spdlog-1.2.1/include",
		"%{wks.location}/src",
		"%{wks.location}/%{IncludeDir.GLFW}",
		"%{wks.location}/%{IncludeDir.glm}",
		"%{wks.location}/%{IncludeDir.ImGui}",
		"%{wks.location}/%{IncludeDir.entt}"
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
			"GLFW_INCLUDE_NONE",
			"_SILENCE_STDEXT_ARR_ITERS_DEPRECATION_WARNING"
		}

		postbuildcommands { 'xcopy /Y /I /E "%{prj.location}/assets" "%{cfg.targetdir}/assets"' }

	filter "configurations:Debug"
		defines "HZ_DEBUG"
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
