#pragma once

#include "entt.hpp"

#include "Hazel/Renderer/EditorCamera.h"
#include "Hazel/Core/Timestep.h"
#include "Hazel/Renderer/EditorCamera.h"

namespace Hazel {

	class Entity;

	class Scene
	{
	public:
		Scene();
		~Scene();

		Entity CreateEntity(const std::string& name = std::string());
		void DestroyEntity(Entity entity);

		void OnUpdateRuntime(Timestep ts);
		void OnUpdateEditor(Timestep ts, EditorCamera& camera);
		void OnViewportResize(uint32_t width, uint32_t height);
		Entity GetPrimaryCameraEntity();

		// bool IsEntityValid(entt::entity entity) const { return m_Registry.valid(entity); }
	private:
		template<typename T>
		void OnComponentAdded(Entity entity, T& component);
	private:
		entt::registry m_Registry;
		uint32_t m_ViewportWidth = 0, m_ViewportHeight = 0;

		friend class Entity;
		friend class SceneHierarchyPanel;
		friend class SceneSerializer;
	};

}
