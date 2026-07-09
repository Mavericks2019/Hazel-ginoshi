#include "hzpch.h"
#include "Hazel.h"
#include "Sandbox2D.h"
#include "GameLayer/GameLayer.h"
#include "Hazel/ImGui/ImGuiLayer.h"
#include "ExampleLayer.h"

class Sandox : public Hazel::Application
{
public:
    Sandox(Hazel::ApplicationCommandLineArgs args)
        : Application("Sandbox", args)
    {
        //PushOverlay(new Hazel::ImGuiLayer());
        //PushLayer(new ExampleLayer());
        PushLayer(new Sandbox2D());
        //PushLayer(new GameLayer());
    }
    ~Sandox() {}
};

Hazel::Application* Hazel::CreateApplication(Hazel::ApplicationCommandLineArgs args)
{
    return new Sandox(args);
}
