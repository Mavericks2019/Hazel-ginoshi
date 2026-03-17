
#include "Hazel.h"

class Sandox : public Hazel::Application
{
public:
	Sandox() 
	{

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
