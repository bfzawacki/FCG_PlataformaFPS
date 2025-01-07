#version 330 core

// Atributos de fragmentos recebidos como entrada ("in") pelo Fragment Shader.
// Neste exemplo, este atributo foi gerado pelo rasterizador como a
// interpolação da posição global e a normal de cada vértice, definidas em
// "shader_vertex.glsl" e "main.cpp".
in vec4 position_world;
in vec4 normal;

// Posição do vértice atual no sistema de coordenadas local do modelo.
in vec4 position_model;

// Coordenadas de textura obtidas do arquivo OBJ (se existirem!)
in vec2 texcoords;

// Nova entrada para a cor calculada pelo vertex shader (Gouraud Shading)
in vec4 vertexcolor;

// Matrizes computadas no código C++ e enviadas para a GPU
uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;

// Identificador que define qual objeto está sendo desenhado no momento
#define ISLAND 0
#define PLAYER 1
#define COW 2
uniform int object_id;

// Parâmetros da axis-aligned bounding box (AABB) do modelo
uniform vec4 bbox_min;
uniform vec4 bbox_max;

// Variáveis para acesso das imagens de textura
uniform sampler2D TextureImage0;
uniform sampler2D TextureImage1;
uniform sampler2D TextureImage2;

// O valor de saída ("out") de um Fragment Shader é a cor final do fragmento.
out vec4 color;

// Constantes
#define M_PI   3.14159265358979323846
#define M_PI_2 1.57079632679489661923


void main()
{
    // Obtemos a posição da câmera utilizando a inversa da matriz que define o
    // sistema de coordenadas da câmera.
    vec4 origin = vec4(0.0, 0.0, 0.0, 1.0);
    vec4 camera_position = inverse(view) * origin;

    // O fragmento atual é coberto por um ponto que percente à superfície de um
    // dos objetos virtuais da cena. Este ponto, p, possui uma posição no
    // sistema de coordenadas global (World coordinates). Esta posição é obtida
    // através da interpolação, feita pelo rasterizador, da posição de cada
    // vértice.
    vec4 p = position_world;

    // Normal do fragmento atual, interpolada pelo rasterizador a partir das
    // normais de cada vértice.
    vec4 n = normalize(normal);

    // Vetor que define o sentido da fonte de luz em relação ao ponto atual.
    vec4 l = normalize(vec4(1.0,1.0,0.0,0.0));

    // Vetor que define o sentido da câmera em relação ao ponto atual.
    vec4 v = normalize(camera_position - p);

    // Vetor que define o sentido da reflexão especular ideal.
    vec4 r = reflect(-l, n); 

    // Vetor h utilizado no cálculo do modelo de iluminação de Blinn-Phong
    vec4 h = normalize(v + l);

    // Parâmetros que definem as propriedades espectrais da superfície
    vec3 Kd; // Refletância difusa
    vec3 Ks; // Refletância especular
    vec3 Ka; // Refletância ambiente
    float q; // Expoente especular para o modelo de iluminação de Phong

    // Coordenadas de textura U e V
    float U = 0.0;
    float V = 0.0;


//if ( object_id == ISLAND ) {

    //U = texcoords.x;
    //V = texcoords.y;

    //Ks = vec3(0.5,0.5,0.5);
    //q = 100.0;

//} else 

if ( object_id == PLAYER ) {

    float minx = bbox_min.x;
    float maxx = bbox_max.x;

    float miny = bbox_min.y;
    float maxy = bbox_max.y;

    float minz = bbox_min.z;
    float maxz = bbox_max.z;

    U = (position_model.x - minx)/(maxx - minx);
    V = (position_model.y- miny )/(maxy - miny);

    Ks = vec3(0.5,0.5,0.5);
    q = 40.0;

} else if ( object_id == COW ) {

    float minx = bbox_min.x;
    float maxx = bbox_max.x;

    float miny = bbox_min.y;
    float maxy = bbox_max.y;

    float minz = bbox_min.z;
    float maxz = bbox_max.z;

    U = (position_model.x - minx)/(maxx - minx);
    V = (position_model.y- miny )/(maxy - miny);

} 


// Obtemos a refletância difusa a partir da leitura da imagem TextureImage0
vec3 Kd0 = texture(TextureImage0, vec2(U,V)).rgb;

vec3 Kd1 = texture(TextureImage1, vec2(U,V)).rgb;

vec3 Kd2 = texture(TextureImage2, vec2(U,V)).rgb;

// Espectro da fonte de iluminação
vec3 I = vec3(1.0,1.0,1.0); 

// Espectro da luz ambiente
vec3 Ia = vec3(0.02,0.02,0.02); 

// Equação de Iluminação
float lambert = max(0,dot(n,l));

// Iluminação ambiente
vec3 ambient_term = Ka * Ia; 

// Termo especular utilizando o modelo de iluminação de Phong
vec3 phong_specular_term = Ks * I * pow(max(0, dot(r,v)), q); 

// Termo especular utilizando o modelo de iluminação de Blinn-Phong
vec3 blinn_phong_specular_term = Ks * I * pow(max(0, dot(n,h)), q);

if (object_id == ISLAND) {

    // Uso do modelo de iluminação de Blinn-Phong
    //color.rgb = (Kd0 * I * (lambert + 0.07)) + blinn_phong_specular_term;
    // Uso da cor interpolada pelo vertex shader (Gouraud Shading)
    color = vertexcolor;

} else if (object_id == COW) {

    //Uso do modelo de iluminação difusa de Lambert
    color.rgb = Kd1 * I * (lambert + 0.1);

} else if (object_id == PLAYER){

    //Uso do modelo de iluminação de Phong
    color.rgb = (Kd2 * I * (lambert + 0.1)) + phong_specular_term;

} else {
    // Outros objetos usam Kd0 e Kd1
    color.rgb = Kd0 * (lambert + 0.01) + (Kd1 * max(0, (0.275 - lambert)));
}

    // NOTE: Se você quiser fazer o rendering de objetos transparentes, é
    // necessário:
    // 1) Habilitar a operação de "blending" de OpenGL logo antes de realizar o
    //    desenho dos objetos transparentes, com os comandos abaixo no código C++:
    //      glEnable(GL_BLEND);
    //      glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    // 2) Realizar o desenho de todos objetos transparentes *após* ter desenhado
    //    todos os objetos opacos; e
    // 3) Realizar o desenho de objetos transparentes ordenados de acordo com
    //    suas distâncias para a câmera (desenhando primeiro objetos
    //    transparentes que estão mais longe da câmera).
    // Alpha default = 1 = 100% opaco = 0% transparente
    color.a = 1;

    // Cor final com correção gamma, considerando monitor sRGB.
    // Veja https://en.wikipedia.org/w/index.php?title=Gamma_correction&oldid=751281772#Windows.2C_Mac.2C_sRGB_and_TV.2Fvideo_standard_gammas
    color.rgb = pow(color.rgb, vec3(1.0,1.0,1.0)/2.2);
}
