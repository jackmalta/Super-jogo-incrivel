// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações

function troca_sprite(_dir, _struct_sprites)
{
    
    switch(_dir)
    {
        case 0: sprite_index = _struct_sprites.lado;  break;
        case 1: sprite_index = _struct_sprites.cima;  break;
        case 2: sprite_index = _struct_sprites.lado;  break;
        case 3: sprite_index = _struct_sprites.baixo; break;
    }
}

//Função para avisar se a animação acabou
function acabou_animacao()
{
    //Checando se tem uma sprite
    if (sprite_index != -1)
    {
        //Checando se a animação acabou
        var _spd = sprite_get_speed(sprite_index) / game_get_speed(gamespeed_fps);
        if (image_index + _spd >= image_number)
        {
            return true;
        }
    }
    
    return false;
}


//Função para definir as minhas sprites
function define_sprite(_entidade_txt, _tipo_txt, _estado_txt)
{
    var _entidade   = _entidade_txt == undefined        ? entidade_txt  : _entidade_txt;
    var _tipo        = _tipo_txt == undefined           ? tipo_txt       : _tipo_txt;
    var _estado     = _estado_txt == undefined          ? estado_txt    : _estado_txt;
    
    var _minhas_sprites  = global.lista_sprites[$ _entidade][$ _tipo][$ _estado];
    
    image_index     = 0;
    
    //Retornando a lista de sprites
    return _minhas_sprites;
}

//Minha função para criar as colisões
function cria_colisao()
{
    //Determinando o tamanho do tileset
    var _tam = 32;
    //Determinando a quantidade de linhas e colunas
    var _cols = round(room_width / _tam);
    var _lins = round(room_height / _tam);
    
    //Tilemaps que eu vou trabalhar
    var _fundo      = layer_tilemap_get_id("Fundo");
    var _colisao    = layer_tilemap_get_id("Colisao");
    var _tile       = tile_set_index(_cols, 1);
    
    
    //Rodando por toda a minha room
    for (var i = 0; i < _cols; i++)
    {
        for (var j = 0; j < _lins; j++)
        {
            //Descobrindo qual o tile atual
            var _atual = tilemap_get(_fundo, i, j);
            
            //Se o atual não for 8 ou 0, tem colisão
            if (_atual != 8 && _atual != 0)
            {
                //Aqui eu coloco um tile de colisão
                //Na camada de colisão
                tilemap_set(_colisao, _tile, i, j);
                
            }
            
        }
    }
    
}

//Função para a geração de "perigo"
function cria_perigo(_obj = obj_olho, _dist = 2)
{
    var _size = 32;
    //Determinando minha posição do x1 e y1
    var _x1 = max((x div _size) - _dist, 0);
    var _y1 = max((y div _size) - _dist, 0);
    
    var _x2 = _x1 + _dist*2;
    var _y2 = _y1 + _dist*2;
    
    var _lista = detecta_tile(0, _x1, _y1, _x2, _y2);
    //Criando o olho
    //Pegando um mano da minha lista aleatoriamente
    var _tam = array_length(_lista);
    if (_tam <= 0) return;
    
    //Só chego aqui se o tamanho da minha lista é válido
    var _ind = irandom(_tam-1);
    var _atual = _lista[_ind];
    
    var _x = _atual.x * _size;
    var _y = _atual.y * _size;
    
    cria_entidade(_x, _y, _obj);
    
}


//Função para checar o tile
function detecta_tile(_tl = 0, _x1, _y1, _x2 = -1, _y2 = -1)
{
    
    //Se a posição final não foi determinada, eu mesmo faço isso
    //A grid tem o tamanho de 32 por 32
    if (_x2 < 0) _x2 = _x1 + 20; //Na grid
    if (_y2 < 0) _y2 = _y1 + 20; //Na grid
    
    //Determinando o tamanho da área que eu devo checar
    //Vou olhar a room inteira
    var _size = 32;
    var _cols = round(room_width / _size);
    var _lins = round(room_height / _size);
    
    //Determinando o tileset que eu vou olhar
    var _tile = layer_get_id("Fundo");
    var _lay  = layer_tilemap_get_id("Fundo");
    
    //Lista de tiles que eu posso fazer coisas
    var _lista = [];
    
    for (var i = _x1; i < _x2; i++)
    {
        for (var j = _y1; j < _y2; j++)
        {
            //Pegando a informação do tile atual
            var _atual = tilemap_get(_lay, i, j);
            
            //Se o tile atual for o mesmo do tl desejado, eu guardo ele na lista
            if (_atual == _tl)
            {
                //Criando uma estrutura com a posição x e y
                var _vec2 = {x: i, y: j};
                array_push(_lista, _vec2);
                
                //Já usei o vec2, eu vou deletar ele
                delete _vec2;
            }
        }
    }
    
    //Vou retornar a minha com todas as posições livres
    return _lista;

}

//Função para criar o olho em algum local
function cria_entidade(_x, _y, _obj = obj_olho)
{
    //Checar se a posição onde eu to tentando criar o olho
    //Esta livre
    //Checando se o quadrado todo ta livre
    var _livre = !collision_rectangle(_x, _y, _x + 32, _y + 32, obj_perigo, 0, 1);
    //show_message(_livre)
    
    
    if (_livre)
    {
        instance_create_depth(_x, _y, 0, _obj);
    }
}





