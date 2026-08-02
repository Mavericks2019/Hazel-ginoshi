#include <Hazel.h>
#include <Hazel/Core/EntryPoint.h>
#include <Hazel/Renderer/Shader.h>

#include "EditorLayer.h"

namespace Hazel {

	class Hazelnut : public Application
	{
	public:
		Hazelnut(ApplicationCommandLineArgs args)
			: Application("Hazelnut", args)
		{
			// Use SPIR-V shader compilation for UBO-based shaders (Hazelinput's Texture.glsl)
			Shader::SetDefaultCompileMode(ShaderCompileMode::SPIRV);

			PushLayer(new EditorLayer());
		}

		~Hazelnut()
		{
		}
	};

	Application* CreateApplication(ApplicationCommandLineArgs args) {
		return new Hazelnut(args);
	}

}
