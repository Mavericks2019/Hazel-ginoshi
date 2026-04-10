#include "hzpch.h"
#include "Hazel.h"
#include "Sandbox2D.h"
#include "GameLayer/GameLayer.h"
#include "Hazel/ImGui/ImGuiLayer.h"
#include "ExampleLayer.h"

class Sandox : public Hazel::Application
{
public:
    Sandox()
    {
        //PushOverlay(new Hazel::ImGuiLayer());
        //PushLayer(new ExampleLayer());
        //PushLayer(new GameLayer());
        PushLayer(new Sandbox2D());
    }
    ~Sandox() {}
};

Hazel::Application* Hazel::CreateApplication()
{
    return new Sandox();
}