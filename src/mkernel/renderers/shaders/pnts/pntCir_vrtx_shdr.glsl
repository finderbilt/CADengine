#version 450 core

layout (location = 0) in vec4 vtx;
layout (location = 1) in vec4 clr;
layout (location = 2) in float dia;
layout (location = 3) in vec3 cid;

layout (location = 0) uniform mat4 MM = mat4(1.0);
layout (location = 1) uniform mat4 VM = mat4(1.0);
layout (location = 2) uniform mat4 PM = mat4(1.0);
layout (location = 4) uniform vec4 VPP; // viewport pixel property (posx, posy, width, height)

out vsOut {
    out vec3 cid;
    out vec4 fclr;
    out vec2 radVec;
    out vec2 center;
} vs_out;

void main() {
    vs_out.cid = cid;
    vs_out.fclr = clr;
    // camera space point
    vec4 csPnt = VM*MM*vtx;
    // radius vector at normalized device coordinate
    // ! PM will squach vector in relative with viewport ratio
    vec4 csRadVec = PM*vec4(dia/2, dia/2, csPnt.z, 1);
    // size from unit to pixel
    gl_PointSize = ((csRadVec.x/csRadVec.w)*VPP.z);
    // size from projection space to ndc
    vs_out.radVec = csRadVec.xy/csRadVec.w;
    // projection space point
    vec4 psPnt = PM*csPnt;

    vs_out.center = psPnt.xy/psPnt.w;
    gl_Position = psPnt;
}
