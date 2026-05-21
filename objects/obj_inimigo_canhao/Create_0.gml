/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor


#region variaveis

//Variáveis de movimentação
vel     = 1;
velh    = 0;
velv    = 0;

dir     = 0;

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
    
    
    //zero meu velh e velv
    velh = 0;
    velv = 0;
}

estado_idle.roda = function()
{
    
    timer_idle--;
    
    //Testando se o player esta na minha linha de visão
    var _dist = 100;
    var _x2 = x + lengthdir_x(_dist, dir * 90);
    var _y2 = y + lengthdir_y(_dist, dir * 90);
    
    var _player = collision_line(x, y, _x2, _y2, global.player_atual, 0, 1);
    
    if (_player) 
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
    var _x = random(room_width);
    var _y = random(room_height);
    
    //Definindo a direção que eu vou andar
    var _dir = point_direction(x, y, _x, _y);
    
    //Definindo as minhas velocidade
    velh = lengthdir_x(vel, _dir);
    velv = lengthdir_y(vel, _dir);
    
}

estado_walk.roda = function()
{
    
    timer_idle--;
    
    
    //Testando se o player esta na minha linha de visão
    var _dist = 100;
    var _x2 = x + lengthdir_x(_dist, dir * 90);
    var _y2 = y + lengthdir_y(_dist, dir * 90);
    
    var _player = collision_line(x, y, _x2, _y2, global.player_atual, 0, 1);
    
    if (_player) 
    {
        troca_estado(estado_prepara);
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
    }
    
}


#endregion


#region estado espera

estado_espera.inicia = function()
{
    estado_txt = "espera";
    
    minhas_sprites = define_sprite();
    
    troca_sprite(dir, minhas_sprites);
    
    //TODO criar a espera do jeito certo
    timer_idle = 60;
    
}

estado_espera.roda = function()
{
    timer_idle--;
    
    troca_sprite(dir, minhas_sprites);
    
    if (timer_idle <= 0)
    {
        troca_estado(estado_recarga);
        timer_idle = random_range(tempo_idle/2, tempo_idle);
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
