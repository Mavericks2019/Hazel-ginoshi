#include "hzpch.h"
#include "Application.h"
#include "Hazel/Events/ApplicationEvent.h"
#include "Hazel/Log.h"
#include <iostream>

namespace Hazel {

	Application::Application()
	{
	}

	Application::~Application()
	{
	}

	void Application::Run()
	{
		WindowResizeEvent e(1280, 720);
		std::cout << e << std::endl;
		HZ_CLIENT_TRACE(e); // change spdlog version
		HZ_CLIENT_TRACE(e); // change spdlog version

		while(true);
	}
}