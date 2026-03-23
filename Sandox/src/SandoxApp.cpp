
#include "hzpch.h"
#include "Hazel.h"

class ExampleLayer : public Hazel::Layer
{
public:
	ExampleLayer()
		: Layer("Example")
	{

	}
	void OnUpdate() override
	{
		//HZ_CLIENT_INFO("ExampleLayer::Update");

		if(Hazel::Input::IsKeyPressed(HZ_KEY_TAB))
		{
			HZ_CLIENT_INFO("TAB");
		}
	}

	void OnEvent(Hazel::Event& event) override
	{
		if (event.GetEventType() == Hazel::EventType::KeyPressed)
		{
			Hazel::KeyPressedEvent& e = (Hazel::KeyPressedEvent&)event;
			HZ_CLIENT_TRACE((char)e.GetKeyCode());
		}
	}

};

class Sandox : public Hazel::Application
{
public:
	Sandox() 
	{
		PushLayer(new ExampleLayer());
		PushOverlay(new Hazel::ImGuiLayer());
	}
	~Sandox() 
	{

	}

private:

};

Hazel::Application* Hazel::CreateApplication()
{
	return new Sandox();
}
