/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor


#region variaveis

minhas_sprites = global.lista_sprites.verde;

dir = 3;

espera_tiro = 10;
delay_tiro  = 0;


//Inputs
up      = 0;
down    = 0;
left    = 0;
right   = 0;
attack  = 0;


//Movimentação
vel     = 2;
velh    = 0;
velv    = 0;

#endregion

#region inicia estados
estado_vazio = new estado();
estado_preenche = new estado();
estado_cheio = new estado();
estado_idle  = new estado();
estado_walk  = new estado();
#endregion

#region estados

#region estado_vazio
estado_vazio.inicia = function()
{
    //A minha sprite ta na minha lista de sprites
    sprite_index = spr_personagem_vazio;
}

#endregion

#region estado preenche
estado_preenche.inicia = function()
{
    sprite_index = minhas_sprites.transicao.entrando;
    image_index  = 0;
}

estado_preenche.roda = function()
{
    //Se a animação acabou, eu troco de estado
    if (image_index >= image_number - 1)
    {
        troca_estado(estado_idle);
    }
}

#endregion


#region estado_cheio - Atualmente não esta em uso
estado_cheio.inicia = function()
{
    sprite_index = minhas_sprites.idle.baixo;
}

#endregion


#region estado_idle

estado_idle.inicia = function()
{
    troca_sprite(dir, minhas_sprites.idle);
    image_index = 0;
}

estado_idle.roda = function()
{
    troca_sprite(dir, minhas_sprites.idle);
    checa_inputs();
    atirando();
    ajusta_direcao();
    
    if (up or down or left or right)
    {
        troca_estado(estado_walk);
    }
}

#endregion

#region estado_walk

estado_walk.inicia = function()
{
    troca_sprite(dir, minhas_sprites.walk);
    image_index = 0;
}

estado_walk.roda = function()
{
    troca_sprite(dir, minhas_sprites.walk);
    checa_inputs();
    aplica_velocidade();
    ajusta_direcao();
    atirando();
    
    //Saindo do estado
    if (velh == 0 && velv == 0)
    {
        troca_estado(estado_idle);
    }
    
}

#endregion



#endregion

#region metodos

checa_inputs = function()
{
    up      = keyboard_check(ord("W"));
    down    = keyboard_check(ord("S"));
    left    = keyboard_check(ord("A"));
    right   = keyboard_check(ord("D"));
    
    attack  = keyboard_check(vk_space);
}

ajusta_direcao = function()
{
    //Só faço isso se eu estou apertando alguma tecla
    if (up || down || left || right)
    {
        dir = point_direction(0, 0, velh, velv) div 90;
    }
    
    //Ajustando o xscale dele para ele olhar para os dois lados?
    if (velh != 0)
    {
        image_xscale = sign(velh);
    }
        
}

aplica_velocidade = function()
{
    velh = (right - left) * vel;
    velv = (down - up) * vel;
    
    move_and_collide(velh, velv, obj_colisao);
}


atirando = function()
{
    //Sempre diminuir o delay do tiro se ele for maior do que 0
    if (delay_tiro > 0) delay_tiro--;
        
    
    if (attack && delay_tiro <= 0)
    {
        //Criando o meu tiro
        var _tiro = instance_create_depth(x, y - 10, depth - 1, obj_tiro_player);
        
        _tiro.velh = lengthdir_x(5, dir * 90);
        _tiro.velv = lengthdir_y(5, dir * 90);
        _tiro.morrer = random_range(30, 90);
        
        //Resetando o delay do tiro
        delay_tiro = espera_tiro;
        
    }
}

#endregion

inicia_estado(estado_vazio);