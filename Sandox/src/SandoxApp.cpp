
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
		HZ_CLIENT_INFO("ExampleLayer::Update");
	}

	void OnEvent(Hazel::Event& event) override
	{
		HZ_CLIENT_INFO(event);
	}

};

class Sandox : public Hazel::Application
{
public:
	Sandox() 
	{
		//PushLayer(new ExampleLayer());
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
