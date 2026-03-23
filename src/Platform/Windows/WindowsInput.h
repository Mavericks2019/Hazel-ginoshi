#pragma once
#include "Hazel/input.h"


namespace Hazel {
	class WindowsInput : public Input
	{
	protected:
		virtual bool IsKeyPressedImpl(int KeyCode);
		virtual bool IsMouseButtonPressedImpl(int KeyCode);
		virtual float GetMouseXImpl();
		virtual float GetMouseYImpl();
		virtual std::pair<float, float> GetMousePositionImpl();

	};
}