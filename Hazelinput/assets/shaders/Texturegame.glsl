#type vertex
#version 450 core

layout(location = 0) in vec3 a_Position;
layout(location = 1) in vec2 a_TextCoord;

layout(std140, binding = 0) uniform Camera
{
	mat4 u_ViewProjection;
	mat4 u_Transform;
};

layout(location = 0) out vec2 v_TextCoord;

void main()
{
	v_TextCoord = a_TextCoord;
	gl_Position = u_ViewProjection * u_Transform * vec4(a_Position, 1.0);
}

#type fragment
#version 450 core

layout(location = 0) out vec4 color;

layout(location = 0) in vec2 v_TextCoord;

layout(std140, binding = 0) uniform Material
{
	vec4 u_Color;
	float m_TilingFactor;
};

layout(binding = 1) uniform sampler2D u_Texture;

void main()
{
	color = texture(u_Texture, v_TextCoord * m_TilingFactor) * u_Color;
}
