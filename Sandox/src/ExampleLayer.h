#pragma once

#include "hzpch.h"
#include "Hazel.h"
#include "imgui.h"

class ExampleLayer : public Hazel::Layer
{
public:
    ExampleLayer();
    virtual ~ExampleLayer() = default;

    void OnUpdate(Hazel::Timestep ts) override;
    void OnImGuiRender() override;
    void OnEvent(Hazel::Event& event) override;

private:
    Hazel::ShaderLibrary m_ShaderLib;
    Hazel::Ref<Hazel::Shader> m_Shader;
    Hazel::Ref<Hazel::Shader> m_flatColorShader;
    Hazel::Ref<Hazel::VertexArray> m_VertexArray;
    Hazel::Ref<Hazel::VertexArray> m_SquareVA;
    Hazel::Ref<Hazel::Texture2D> m_Texture;
    Hazel::Ref<Hazel::Texture2D> m_Texture2;

    Hazel::OrthographicCameraController m_CameraController;
    glm::vec3 m_SquareColor = { 0.2f, 0.3f, 0.8f };
};