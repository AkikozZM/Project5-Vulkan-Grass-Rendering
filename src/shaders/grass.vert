
#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 1, binding = 0) uniform ModelBufferObject {
    mat4 model;
};

// Declare vertex shader inputs and outputs
layout(location = 0) in vec4 i_v0;
layout(location = 1) in vec4 i_v1;
layout(location = 2) in vec4 i_v2;
layout(location = 3) in vec4 i_up;

layout(location = 0) out vec4 o_v0;
layout(location = 1) out vec4 o_v1;
layout(location = 2) out vec4 o_v2;
layout(location = 3) out vec4 o_up;


out gl_PerVertex {
    vec4 gl_Position;
};

void main() {
    o_v0 = vec4(vec3(model * vec4(i_v0.xyz, 1.0)), i_v0.w);
    o_v1 = vec4(vec3(model * vec4(i_v1.xyz, 1.0)), i_v1.w);
    o_v2 = vec4(vec3(model * vec4(i_v2.xyz, 1.0)), i_v2.w);
    o_up = vec4(vec3(model * vec4(i_up.xyz, 1.0)), i_up.w);
}
