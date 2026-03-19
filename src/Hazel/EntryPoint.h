#pragma once

#ifdef HZ_PLATFORM_WINDOWS

extern Hazel::Application* Hazel::CreateApplication();

int main(int argc, char** argv) 
{
	Hazel::Log::Init();
	HZ_CORE_WARN("test log!");
	int a = 10;
	HZ_CLIENT_INFO("Hello var = {0}!", a);
	HZ_CLIENT_TRACE("Hello var = {0}!", a);
	auto app = Hazel::CreateApplication();
	app->Run();
	delete app;
}

#endif // HZ_PLATFORM_WINDOWS
