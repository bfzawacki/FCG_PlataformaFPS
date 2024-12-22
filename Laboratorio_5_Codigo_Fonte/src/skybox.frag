#version 330 core
#extension GL_ARB_separate_shader_objects : enable

out vec4 FragColor;

in vec3 texCoords;

uniform samplerCube skybox;

void main()
{    
    FragColor = texture(skybox, texCoords);
}