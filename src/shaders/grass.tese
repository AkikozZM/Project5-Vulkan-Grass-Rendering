#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// Declare tessellation evaluation shader inputs and outputs
layout(location = 0) in vec4 i_v0[];
layout(location = 1) in vec4 i_v1[];
layout(location = 2) in vec4 i_v2[];
layout(location = 3) in vec4 i_up[];

layout(location = 0) out vec3 o_position;
layout(location = 1) out vec3 o_normal;
layout(location = 2) out vec2 o_uv;

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
    // fetch data
    vec3 v0 = i_v0[0].xyz;
    vec3 v1 = i_v1[0].xyz;
    vec3 v2 = i_v2[0].xyz;
    vec3 up = i_up[0].xyz;

    float orientation = i_v0[0].w;
    float height = i_v1[0].w;
    float width = i_v2[0].w;
    float stiffCoe = i_up[0].w; // stiffness coefficient
    // De-Casteljau
    vec3 a = mix(v0, v1, v);
    vec3 b = mix(v1, v2, v);
    vec3 t_direction_0 = normalize(b - a);
    vec3 t_direction_1 = normalize(vec3(cos(orientation), 0.0, sin(orientation)));
    float t = (0.5 * v + u) - (v * u);
    vec4 pos = vec4(mix(mix(a, b, v) - width * t_direction_1, mix(a, b, v) + width * t_direction_1, t), 1.0);

    gl_Position = camera.proj * camera.view * pos;
    o_position = vec3(gl_Position);
    o_uv = vec2(u, v);
    o_normal = cross(t_direction_0, t_direction_1);
}
