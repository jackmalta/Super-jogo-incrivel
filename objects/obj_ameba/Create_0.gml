/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor
//Iniciando o estado idle


cria_colisao();

#region variaveis
velh = 0;
velv = 0;
max_vel = 1;

//Eu preciso saber quais as minhas informações
cor_txt         = "verde";
estado_txt      = "idle";
entidade_txt    = "ameba";
 


dir = 0;
minhas_sprites = global.lista_sprites[$ entidade_txt][$ cor_txt][$ estado_txt];

//Variável com as colisões
var _tile = layer_tilemap_get_id("Colisao");

colisoes = [_tile, obj_personagem];





//Meus controles
up      = 0;
down    = 0;
left    = 0;
right   = 0;


#endregion



#region cria estados
estado_idle = new estado();
estado_walk = new estado();
estado_entrando = new estado();
#endregion

#region estados

#region estado_idle

estado_idle.inicia = function()
{
    estado_txt = "idle";
    minhas_sprites = global.lista_sprites[$ entidade_txt][$ cor_txt][$ estado_txt];
    
    troca_sprite(dir, minhas_sprites);
}

estado_idle.roda = function()
{
    checa_inputs();
    
    //Condição para ir para o estado de walk
    //Se eu apertei algum botão, eu mudo de estado
    if (up or down or left or right)
    {
        troca_estado(estado_walk);
    }
    
    
    var _buraco = instance_place(x, y - 5, obj_buraco_menu);
    
    var _personagem = instance_place(x, y - 5, obj_personagem);
    
    //Entrando no personagem
    if (_buraco || _personagem)
    {
        show_debug_message("kkkkk");
        if (keyboard_check_pressed(vk_enter))
        {
            troca_estado(estado_entrando);
        }
    }
    
}

//Saindo do estado
estado_idle.finaliza = function()
{
    
}

#endregion

#region estado walk

estado_walk.inicia = function()
{
    estado_txt = "walk";
    minhas_sprites = global.lista_sprites[$ entidade_txt][$ cor_txt][$ estado_txt];
    
    troca_sprite(dir, minhas_sprites);
}

estado_walk.roda = function()
{
    troca_sprite(dir, minhas_sprites);
    checa_inputs();
    aplica_velocidade();
    
    var _buraco = instance_place(x, y - 5, obj_buraco_menu);
    
    var _personagem = instance_place(x, y - 5, obj_personagem);
    
    //Entrando no personagem
    if (_buraco || _personagem)
    {
        show_debug_message("kkkkk");
        if (keyboard_check_pressed(vk_enter))
        {
            troca_estado(estado_entrando);
        }
    }
    
    
    //Se eu parei eu fico parado
    if (velh == 0 && velv == 0)
    {
        troca_estado(estado_idle);
    }
}

#endregion



#region estado_entrando

//Iniciando o estado
estado_entrando.inicia = function()
{
    estado_txt = "entrando";
    
    y -= 8;
    image_index = 0;
    minhas_sprites = global.lista_sprites[$ entidade_txt][$ cor_txt][$ estado_txt];
    
    troca_sprite(dir, minhas_sprites);
}

estado_entrando.roda = function()
{
    //Checando se eu estou colidindo com o buraco
    var _buraco = instance_place(x, y - 5, obj_buraco_menu);
    var _personagem = instance_place(x, y - 5, obj_personagem);
    //Se a minha animação acabou, eu morro
    if (image_index >= image_number-1)
    {
        if (_buraco)
        {
            //Ativando o buraco
            _buraco.ativo = true;
        }
        
        //Se eu colidi com o personagem, eu vou encher ele comigo mesmo.
        if (_personagem)
        {
            with(_personagem)
            {
                troca_estado(estado_preenche);
            }
        }
        
        instance_destroy();
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
    velh = (right - left) * max_vel;
    velv = (down - up) * max_vel;
    
    move_and_collide(velh, velv, colisoes);
}


#endregion






//Iniciando o estado dele
inicia_estado(estado_idle);
