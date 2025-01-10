# **TropiCow**

## **Descrição do Trabalho**

Este projeto foi desenvolvido por Bruno Fialho e Lucca Claus como parte da disciplina de Fundamentos de Computação Gráfica (INF01047). O objetivo principal foi implementar um jogo 3D que utiliza conceitos estudados durante o curso. TropiCow é um simples jogo onde o jogador precisa pular de ilha em ilha com o objetivo de alcançar uma vaca no fim do cenário.

## **Contribuições dos Membros**

* **Bruno Fialho**: Implementou alguns objetos com texturas como a ilha e o personagem. Contribuiu na criação das hitboxes utilizando as bounding boxes de objetos, mapeou uma nova hitbox para a ilha e para o personagem usando o Blender e adicionou o tratamento para cada colisão.   
* **Lucca Claus**: Trabalhou com a implementação e posicionamento de certos objetos (vaca, player e múltiplas ilhas) e suas respectivas texturas, implementação de modelos de iluminação (Blinn-Phong e difusa (Lambert)) e modelos de interpolação para iluminação (Gouraud) e cutscene inicial do jogo utilizando curva de Bézier cúbica e câmera look-at focada no personagem.  
* **Ambos membros**: Implementação e refinamento do sistema de movimentação do personagem e correções de pequenos bugs e mudanças que contribuíram para uma melhor qualidade do código ao longo do desenvolvimento. Além disso, certificaram que todas as animações presentes fossem baseadas no tempo.

## **Uso de Ferramentas de IA**

No decorrer do desenvolvimento, utilizamos ferramentas de IA (Github Copilot e ChatGPT) para resolver problemas específicos e esclarecer dúvidas sobre implementações complexas. As ferramentas se mostraram especialmente úteis para pequenas correções e para compreender melhor os passos necessários para implementar determinadas funcionalidades. Por exemplo, quando uma feature não funcionava como esperado, as IA foram cruciais para identificar soluções pontuais. No entanto, em situações onde o problema exigia uma compreensão mais ampla do código, as sugestões nem sempre foram precisas, o que levou a correções inadequadas que acabaram complicando o desenvolvimento. Apesar dessas limitações, o uso de IA foi valioso para acelerar o progresso em momentos de bloqueio. As IA foram principalmente usadas em correções dos shaders para implementação de modelos de iluminação e nas implementações de colisões/hitboxes. Fora essa parte de auxílio no código, utilizamos IA para gerar o modelo da ilha e sua textura.

## **Desenvolvimento e Uso dos Conceitos de Computação Gráfica**

O desenvolvimento foi principalmente baseado em “divisão e conquista”, onde cada membro ficou responsável por partes específicas do projeto, ou seja, um desenvolvimento mais individual. No final do projeto, utilizamos a estratégia de pair programming para alinhar as implementações e corrigir certos bugs que apareceram.

Utilizamos de base o Laboratório 5 da disciplina. Começamos por retirar tudo que não seria útil para o nosso projeto. O primeiro passo foi criar o modelo de uma ilha e sua textura através da plataforma Meshy.ai. Além disso, encontramos no site Free3D um modelo sem textura para o personagem e o adicionamos para o projeto. Desenvolvemos a movimentação livre do personagem junto com a câmera. Após isso, através da utilização de pilhas, baseando-se no Laboratório 3, instanciamos a ilha mais 5 vezes com matrizes de modelagem diferentes para cada ilha e incluímos um modelo 3D de vaca junto com uma textura na a última ilha. Utilizamos o Blender para modelar objetos que foram mapeados e utilizados como hitbox para a ilha e o jogador. Nós certificamos que as coordenadas das hitboxes e das ilhas desenhadas estavam juntas e fizemos o tratamento das colisões. Aprimoramos a movimentação horizontal do jogador, criamos a física de gravidade e velocidade, adicionamos um pulo e certificamos que todas as animações do personagem e da câmera fossem baseadas no tempo, garantindo, assim, uma consistência nas animações independente do hardware onde o jogo for executado. Por fim, adicionamos uma colisão com a vaca que determina o final do jogo.   

No início do jogo, implementamos uma cutscene que aplica os conceitos de câmera look-at (nesse caso, focada no player) e de curva de Bézier cúbica, que define a rota da câmera na cutscene. No restante do jogo, utilizamos uma câmera livre em primeira pessoa.

Todos os nossos modelos (vaca, ilha e personagem) possuem texturas únicas que foram implementadas a partir do mapeamento de imagens jpg/png.

Sobre os modelos de iluminação de objetos geométricos usados, foram implementados os modelos de iluminação de Lambert (difusa) e de Blinn-Phong e o Gouraud Shading como modelo de interpolação para iluminação.

Para realizar a implementação das colisões, primeiro foram criados novos modelos que serviram como hitbox para a ilha e o jogador. Inicializamos as bounding boxes do jogador, de cada uma das ilhas e da vaca e depois utilizamos Axis-Aligned Bounding Box (AABB) para checar as colisões e fazer seu tratamento. 

## **Imagens da Aplicação**

## **Manual de Utilização**

* **Teclas de Navegação**: Use as teclas WASD para mover o personagem e Espaço para pular.  
* **Câmera:** Segure o botão esquerdo do mouse e arraste para movimentar a câmera do personagem.

## **Compilação e Execução**

1. **Requisitos**: Certifique-se de ter o OpenGL e GLFW instalados no sistema.  
2. **Compilação**:  
   * Clone o repositório: `git clone https://github.com/bfzawacki/FCG_PlataformaFPS`  
   * Navegue até o diretório do projeto: `cd FCG_PlataformaFPS/Laboratorio_5_Codigo_Fonte`  
   * Compile o projeto: `make`  
3. **Execução**:  
   * Execute a aplicação: `make run`
