/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor


#region variaveis

//Variáveis de movimentação
vel     = 1;
velh    = 0;
velv    = 0;

dir     = 0;

dist = 100;

meu_tiro = noone;

destino_x = 0;
destino_y = 0;

entidade_txt    = "inimigo";
tipo_txt        = "canhao";
estado_txt      = "idle";

minhas_sprites = define_sprite();

colisoes = obj_colisao;

//Timer entre correr e esperar
tempo_idle = 120;
timer_idle = tempo_idle;

#endregion

#region metodos


//Método para checar se o player esta no meu campo de visão
detecta_player = function()
{
    //Testando se o player esta na minha linha de visão
    var _x2 = x + lengthdir_x(dist, dir * 90);
    var _y2 = y + lengthdir_y(dist, dir * 90);
    
    var _player = collision_line(x, y, _x2, _y2, global.player_atual, 0, 1);
    
    return _player;
    
}

cria_tiro = function()
{
        
    
    //Se eu já tenho um tiro, eu não faço nada
    if (meu_tiro != noone) return;
    

    var _x = x;
    var _y = y;
    
    switch (dir)
    {
        case 0: _y = y - sprite_height/4; _x = bbox_right; break;
        case 1: _y = bbox_top; _x = x; break;
        case 2: _y = y - sprite_height/4; _x = bbox_left; break;
    }
    
    
    meu_tiro = instance_create_depth(_x, _y, depth, obj_inimigo_canhao_projetil);
    
    var _len = meu_tiro.vel;
    //Definindo a velocidade e direção do tiro
    var _velh = lengthdir_x(_len, dir * 90);
    var _velv = lengthdir_y(_len, dir * 90);
    
    meu_tiro.velh = _velh;
    meu_tiro.velv = _velv;
    meu_tiro.dir  = dir;
    meu_tiro.depth = depth-1;
}

aplica_velocidade = function()
{
    move_and_collide(velh, 0, colisoes);
    move_and_collide(0, velv, colisoes);
}

#endregion

#region estados
estado_idle     = new estado();
estado_walk     = new estado();
estado_prepara  = new estado();
estado_atira    = new estado();
estado_espera   = new estado();
estado_recarga  = new estado();


#region estado_idle
estado_idle.inicia = function()
{
    estado_txt = "idle";
    
    minhas_sprites = define_sprite();
    
    troca_sprite(dir, minhas_sprites);
    
    //Resetando o timer idle
    timer_idle = random_range(tempo_idle/2, tempo_idle);
}

estado_idle.roda = function()
{
    
    timer_idle--;
    
    var _player_na_reta = detecta_player();
    
    if (_player_na_reta)
    {
        troca_estado(estado_prepara);
    }
    
     
    //Saindo do estado
    if (timer_idle <= 0)
    {
        troca_estado(estado_walk);
        timer_idle = random_range(tempo_idle/2, tempo_idle);
    }
}

#endregion

#region estado walk

estado_walk.inicia = function()
{
    estado_txt = "walk";
    
    minhas_sprites = define_sprite();
    
    troca_sprite(dir, minhas_sprites);
    
    
    //Vou escolher um local para eu ir
    var _x = x + random_range(-dist, dist);
    var _y = y + random_range(-dist, dist);
    
    _x = clamp(_x, 0, room_width);
    _y = clamp(_y, 0, room_height);
    
    destino_x = _x;
    destino_y = _y;
    
    //Definindo a direção que eu vou andar
    var _dir = point_direction(x, y, _x, _y);
    
    //Definindo as minhas velocidade
    velh = lengthdir_x(vel, _dir);
    velv = lengthdir_y(vel, _dir);
    
}

estado_walk.roda = function()
{
    
    timer_idle--;
    
    
    var _player_na_reta = detecta_player();
    
    if (_player_na_reta)
    {
        troca_estado(estado_prepara);
    }
    
    var _dist_min = 20;
    
    //Checando se eu estou próximo do meu destino
    var _dist_destino = point_distance(x, y, destino_x, destino_y);
    if (_dist_destino < 20)
    {
        //posso parar porque eu to de boinha
        troca_estado(estado_idle);
    }
    
    //Descobrindo a minha direção com base na minha movimentação
    dir = point_direction(0, 0, velh, velv) div 90;
    
    troca_sprite(dir, minhas_sprites);
    
    if (timer_idle <= 0)
    {
        troca_estado(estado_idle);
        timer_idle = random_range(tempo_idle/2, tempo_idle);
    }
    
    if (velh != 0) image_xscale = sign(velh);
    
    aplica_velocidade();
}

#endregion


#region estado prepara

estado_prepara.inicia = function()
{
    estado_txt = "prepara";
    
    minhas_sprites = define_sprite();
    
    troca_sprite(dir, minhas_sprites);
    
}


estado_prepara.roda = function()
{
    
    //Depois que acabou a minha animação eu vou para o idle... Por enquanto
    if (image_index > image_number-1)
    {
        troca_estado(estado_atira);
    }
    
}

#endregion


#region atira
estado_atira.inicia = function()
{
    estado_txt = "atira";
    

    //cria_tiro();
    
    minhas_sprites = define_sprite();
    
    troca_sprite(dir, minhas_sprites);
}

estado_atira.roda = function()
{
    troca_sprite(dir, minhas_sprites);
    
    
    //Acabou a animação eu vou para o estado de espera
    //TODO arrumar o código que finaliza a animação
    if (image_index > image_number-1)
    {
        troca_estado(estado_espera);
        //Criando meu tiro
        cria_tiro();
    }
    
}


#endregion


#region estado espera

estado_espera.inicia = function()
{
    estado_txt = "espera";
    
    minhas_sprites = define_sprite();
    
    troca_sprite(dir, minhas_sprites);
    
    
    
    
}

estado_espera.roda = function()
{
    timer_idle--;
    
    troca_sprite(dir, minhas_sprites);
    var _raio_colisao = 4;
    
    var _peguei_tiro = collision_circle(x, y - sprite_height/2, _raio_colisao, meu_tiro, 0, 1);
    
    //var _peguei_tiro = place_meeting(x, y, meu_tiro);
    
    //Se eu peguei meu tiro voltando
    if (_peguei_tiro && meu_tiro.estado_atual == meu_tiro.estado_voltando)
    {
        troca_estado(estado_recarga);
        timer_idle = random_range(tempo_idle/2, tempo_idle);
        
        //Destruindo o meu tiro
        instance_destroy(meu_tiro);
        meu_tiro = noone;
    }
}



#endregion


#region recarrega
estado_recarga.inicia = function()
{
    estado_txt = "recarga";
    
    minhas_sprites = define_sprite();
    
    troca_sprite(dir, minhas_sprites);
}

estado_recarga.roda = function()
{
    if (image_index >= image_number-1)
    {
        troca_estado(estado_idle);
    }
}

#endregion

#endregion

inicia_estado(estado_walk);
