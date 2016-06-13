////////////////////////////////////////////////////////////////////////////////
// BILLBOARD - requires: utilities.glsl
////////////////////////////////////////////////////////////////////////////////

// Returns new quad coordinates vector so they always face the XZ plane
////////////////////////////////////////////////////////////////////////////////
vec4[4] billboardFaceXZ(vec4[4] quad, mat4 viewModel)
{
    for (int i = 0; i < 4; i++)
    {
        quad[i].yz = quad[i].zy;
        quad[i] = viewModel * quad[i];
    }
    
    return quad;
}



// Returns new quad coordinates vector so they face the camera while also
// aligning with the moving direction
////////////////////////////////////////////////////////////////////////////////
vec4[4] billboardDirectionCamera(vec4[4] quad, vec3 dir, vec3 particleToCamera)
{
    dir = normalize(dir);
    particleToCamera = normalize(particleToCamera);
    vec3 up = normalize(cross(dir, particleToCamera));
    vec3 right = normalize(cross(up, dir));
    mat4 orientation = mat4(vec4(dir, 0),
                            vec4(up, 0),
                            vec4(right, 0),
                            vec4(0, 0, 0, 1));
    
    for (int i = 0; i < 4; i++)
        quad[i] =  orientation * quad[i];

    return quad;
}



// Returns new quad coordinates vector so they always face the moving direction
////////////////////////////////////////////////////////////////////////////////
vec4[4] billboardDirection(vec4[4] quad, vec3 dir)
{
    mat4 orientation = construct3DSpace(dir);

    for (int i = 0; i < 4; i++)
        quad[i] =  orientation * quad[i];

    return quad;
}



// Returns new quad coordinates vector so they always face the up axis of the
// moving direction
////////////////////////////////////////////////////////////////////////////////
vec4[4] billboardDirectionUp(vec4[4] quad, vec3 dir)
{
    mat4 orientation = construct3DSpace(dir);

    vec4 tmp = orientation[1];
    orientation[1] = orientation[2];
    orientation[2] = tmp;

    for (int i = 0; i < 4; i++)
        quad[i] =  orientation * quad[i];

    return quad;
}



// Returns new quad coordinates vector so they always face the right axis of the
// moving direction
////////////////////////////////////////////////////////////////////////////////
vec4[4] billboardDirectionRight(vec4[4] quad, vec3 dir)
{
    mat4 orientation = construct3DSpace(dir);
    
    vec4 tmp = orientation[0];
    orientation[0] = orientation[2];
    orientation[2] = tmp;

    for (int i = 0; i < 4; i++)
        quad[i] =  orientation * quad[i];

    return quad;
}

