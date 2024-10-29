#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

layout(location = 0) in vec3 i_position;
layout(location = 1) in vec3 i_normal;
layout(location = 2) in vec2 i_uv;

layout(location = 0) out vec4 outColor;

void main() {
    vec3 green1 = vec3(0.0, 100.0, 0.0);
    vec3 green2 = vec3(50.0, 251.0, 0.0);
    outColor = vec4(mix(green1 / 255.0, green2 / 255.0, i_uv.y), 1.0);
}
