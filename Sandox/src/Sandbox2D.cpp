#include "Sandbox2D.h"
#include <imgui.h>

#include <glm/gtc/matrix_transform.hpp>
#include <glm/gtc/type_ptr.hpp>

#include "Hazel/Core/EntryPoint.h"
#include "Platform/OpenGL/OpenGLShader.h"

Sandbox2D::Sandbox2D()
	: Layer("Sandbox2D"), m_CameraController(1920.0f / 1080.0f), m_SquareColor({ 150 / 255.0f, 51 / 255.0f, 204 / 255.0f, 1.0f })
{

}

void Sandbox2D::OnAttach()
{
	m_SquareVA = Hazel::VertexArray::Create();

	float suqarevertices[5 * 4] = {
		-0.5f, -0.5f, 0.0f,
		 0.5f, -0.5f, 0.0f,
		 0.5f,  0.5f, 0.0f,
		-0.5f,  0.5f, 0.0f
	};

	Hazel::Ref<Hazel::VertexBuffer> m_SquareVB(Hazel::VertexBuffer::Create(suqarevertices, sizeof(suqarevertices)));

	m_SquareVB->SetLayout({
		{ Hazel::ShaderDataType::Float3, "a_Position"},
	});
	m_SquareVA->AddVertexBuffer(m_SquareVB);

	uint32_t squareindices[6] = { 0, 1, 2 ,2, 3, 0 };
	Hazel::Ref<Hazel::IndexBuffer> m_SquareIB(Hazel::IndexBuffer::Create(squareindices, sizeof(squareindices) / sizeof(uint32_t)));
	m_SquareVA->SetIndexBuffer(m_SquareIB);

	m_FlatColorShader = Hazel::Shader::Create("assets/shaders/FlatColor.glsl");

}

void Sandbox2D::OnDetach()
{
}

void Sandbox2D::OnUpdate(Hazel::Timestep ts)
{
	m_CameraController.OnUpdate(ts);

	Hazel::RenderCommand::SetClearColor({ 0.1f, 0.1f, 0.1f, 1 });
	Hazel::RenderCommand::Clear();

	Hazel::Renderer::BeginScene(m_CameraController.GetCamera());

	std::dynamic_pointer_cast<Hazel::OpenGLShader>(m_FlatColorShader)->Bind();
	std::dynamic_pointer_cast<Hazel::OpenGLShader>(m_FlatColorShader)->UploadUniformFloat4("u_Color", m_SquareColor);


	m_FlatColorShader->Bind();
	Hazel::Renderer::Submit(m_FlatColorShader, m_SquareVA, glm::scale(glm::mat4(1.0f), glm::vec3(1.5f)));

	//triangle
	//Hazel::Renderer::Submit(m_Shader, m_VertexArray);
	Hazel::Renderer::EndScene();

}

void Sandbox2D::OnImGuiRender()
{

	ImGui::Begin("Settings");
	ImGui::ColorEdit4("Square Color", glm::value_ptr(m_SquareColor));
	ImGui::End();
}

void Sandbox2D::OnEvent(Hazel::Event& e)
{
	m_CameraController.OnEvent(e);
}
