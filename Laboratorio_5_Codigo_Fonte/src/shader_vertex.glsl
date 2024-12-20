#version 330 core

// Vertex attributes
layout (location = 0) in vec4 model_coefficients; // Vertex position
layout (location = 1) in vec4 normal_coefficients; // Vertex normals
layout (location = 2) in vec2 texture_coefficients; // Texture coordinates

// Uniforms
uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;

// Outputs to Fragment Shader
out vec4 position_world;
out vec4 position_model;
out vec4 normal;
out vec2 texcoords;
out vec3 texCoords; // From the first shader

void main()
{
    // Transform vertex position to clip space
    vec4 pos = projection * view * model * model_coefficients;
    
    // Assign gl_Position with z = w for a fixed depth of 1.0f
    gl_Position = vec4(pos.x, pos.y, pos.w, pos.w);
    
    // Transformations for various coordinate systems
    position_world = model * model_coefficients; // World coordinates
    position_model = model_coefficients; // Model coordinates
    
    // Compute normal in world space
    normal = inverse(transpose(model)) * normal_coefficients;
    normal.w = 0.0;
    
    // Pass texture coordinates from model
    texcoords = texture_coefficients;
    
    // Compute texCoords with flipped z-axis for the second shader's logic
    texCoords = vec3(model_coefficients.x, model_coefficients.y, -model_coefficients.z);
}