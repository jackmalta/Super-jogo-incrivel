// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações


//Criando meus conjuntos de sprites
var _verde = 
{
    idle:
    {
        cima    : spr_personagem_verde_idle_cima,
        baixo   : spr_personagem_verde_idle_baixo,
        lado    : spr_personagem_verde_idle_lado,
    },
    
    walk:
    {
        cima    : spr_personagem_verde_walk_cima,
        baixo   : spr_personagem_verde_walk_baixo,
        lado    : spr_personagem_verde_walk_lado
    },
    
    transicao:
    {
        entrando    : spr_personagem_verde_entrando,
        saindo      : spr_personagem_verde_saindo,
        vazio       : spr_personagem_vazio
    }
};


global.lista_sprites = 
{
    verde : _verde
};

//Já usei a struct _verde, eu posso deletar ela
delete _verde;


