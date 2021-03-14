workspace "ndi-server"
	startproject "ndi-server"
	architecture "x86_64"
	
	configurations
	{
		"Debug",
		"Release",
		"Optik"
	}
	
	flags
	{
		"MultiProcessorCompile"
	}
	
	
project "ndi-server"
	kind "ConsoleApp"
	language "C++"
	cppdialect "C++17"
	staticruntime "off"

	targetdir ("%{prj.location}/bin/%{prj.name}-%{cfg.system}-%{cfg.architecture}/")
	objdir ("%{prj.location}/bin-int/%{prj.name}-%{cfg.system}-%{cfg.architecture}/")

	includedirs
	{
		"%{prj.location}/vendor/sockpp/include/"
	}
	
	libdirs
	{
		"%{prj.location}/vendor/sockpp/bin/sockpp-%{cfg.system}-%{cfg.architecture}/"
	}
	
	filter "system:windows"
		systemversion "latest"
		links
		{
			"ws2_32",
			"sockpp"
		}
		
	filter "system:not_windows"
		links
		{
			"sockpp"
		}
	
	filter "configurations:Debug"
		defines "__DEBUGLOG"
		runtime "Debug"
		symbols "on"
		files
		{
			"src/**.h",
			"src/**.cpp"
		}

	
	filter "configurations:Release"
		defines "NDEBUG"
		runtime "Release"
		optimize "on"
		files
		{
			"src/**.h",
			"src/**.cpp"
		}

	filter "configurations:Optik"
		defines "__PROFILE"
		runtime "Release"
		optimize "on"
		files
		{
			"src/**.h",
			"src/**.cpp",
			"vendor/optik/**.h",
			"vendor/optik/**.cpp"
		}
		
include "vendor/sockpp/"