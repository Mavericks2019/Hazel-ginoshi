#pragma once
#include "Core.h"
#include "Hazel/Events/Event.h"
#include "Hazel/Events/ApplicationEvent.h"
#include "window.h"
#include "LayerStack.h"

#include "Hazel/ImGui/ImGuiLayer.h"

#include "Hazel/Core/Timestep.h"

#ifdef HZ_PLATFORM_WINDOWS
	#include <windows.h>
#endif
#include "glfw/glfw3.h"

namespace Hazel {

	struct ApplicationCommandLineArgs
	{
		int Count = 0;
		char** Args = nullptr;

		const char* operator[](int index) const
		{
			HZ_CORE_ASSERT(index < Count);
			return Args[index];
		}
	};

	class Application
	{
	public:
		Application(const std::string& name = "Hazel App", ApplicationCommandLineArgs args = ApplicationCommandLineArgs());
		virtual ~Application();
		void OnEvent(Event& e);

		void PushLayer(Layer* layer);
		void PushOverlay(Layer* layer);
		void Close();
		inline static Application& Get() { return *s_Instance; }

		ApplicationCommandLineArgs GetCommandLineArgs() const { return m_CommandLineArgs; }
		inline Window& GetWindow() { return *m_Window; }
		ImGuiLayer* GetImGuiLayer() { return m_ImGuiLayer; }
		void Run();
	private:
		Scope<Window> m_Window;
		ImGuiLayer* m_ImGuiLayer;
		bool m_Running = true;
		bool m_Minimized = false;
		ApplicationCommandLineArgs m_CommandLineArgs;

		bool OnWindowClose(WindowCloseEvent& e);
		bool OnWindowResize(WindowResizeEvent& e);
		LayerStack m_LayerStack;
	private:
		static Application* s_Instance;
		float m_LastFrametime = 0.0f;
	};

	Application* CreateApplication(ApplicationCommandLineArgs args);
}
