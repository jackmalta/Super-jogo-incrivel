// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações


#region Variaveis globais normais

global.player_atual = noone;

#endregion


#region amebas

#region verde
var _ameba_verde =
{
    idle:
    {
        cima    : spr_ameba_verde_idle_cima,
        lado    : spr_ameba_verde_idle_lado,
        baixo   : spr_ameba_verde_idle_baixo,
    },
    
    walk:
    {
        cima    : spr_ameba_verde_walk_cima,
        lado    : spr_ameba_verde_walk_lado,
        baixo   : spr_ameba_verde_walk_baixo,
    },
    
    entrando:
    {
        cima    : spr_ameba_verde_entrando,
        lado    : spr_ameba_verde_entrando,
        baixo   : spr_ameba_verde_entrando,
    },
    
    saindo:
    {
        cima    : spr_ameba_verde_saindo,
        lado    : spr_ameba_verde_saindo,
        baixo   : spr_ameba_verde_saindo,
    }
}


#endregion


#region vermelha
var _ameba_vermelha =
{
    idle:
    {
        cima    : spr_ameba_vermelha_idle_cima,
        lado    : spr_ameba_vermelha_idle_lado,
        baixo   : spr_ameba_vermelha_idle_baixo,
    },
    
    walk:
    {
        cima    : spr_ameba_vermelha_walk_cima,
        lado    : spr_ameba_vermelha_walk_lado,
        baixo   : spr_ameba_vermelha_walk_baixo,
    },
    
    entrando:
    {
        cima    : spr_ameba_vermelha_entrando,
        lado    : spr_ameba_vermelha_entrando,
        baixo   : spr_ameba_vermelha_entrando,
    },
    
    saindo:
    {
        cima    : spr_ameba_vermelha_saindo,
        lado    : spr_ameba_vermelha_saindo,
        baixo   : spr_ameba_vermelha_saindo,
    }
}

#endregion

#endregion


#region personagem


//Criando meus conjuntos de sprites do personagem
#region verde
var _personagem_verde = 
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
    
    entrando:
    {
        cima    : spr_personagem_verde_entrando,
        baixo   : spr_personagem_verde_entrando,
        lado    : spr_personagem_verde_entrando
    },
    
    saindo:
    {
        cima    : spr_personagem_verde_saindo,
        baixo   : spr_personagem_verde_saindo,
        lado    : spr_personagem_verde_saindo
    }
};

#endregion

#region vermelha
var _personagem_vermelha = 
{
    idle:
    {
        cima    : spr_personagem_vermelha_idle_cima,
        baixo   : spr_personagem_vermelha_idle_baixo,
        lado    : spr_personagem_vermelha_idle_lado,
    },
    
    walk:
    {
        cima    : spr_personagem_vermelha_walk_cima,
        baixo   : spr_personagem_vermelha_walk_baixo,
        lado    : spr_personagem_vermelha_walk_lado
    },
    
    entrando:
    {
        cima    : spr_personagem_vermelha_entrando,
        baixo   : spr_personagem_vermelha_entrando,
        lado    : spr_personagem_vermelha_entrando
    },
    
    saindo:
    {
        cima    : spr_personagem_vermelha_saindo,
        baixo   : spr_personagem_vermelha_saindo,
        lado    : spr_personagem_vermelha_saindo
    }
};

#endregion


#endregion


#region estruturas

global.lista_sprites = 
{
    ameba :
    {
        verde       : _ameba_verde,
        vermelha    : _ameba_vermelha
    },
    
    personagem :
    {
        verde       : _personagem_verde,
        vermelha    : _personagem_vermelha
    }
};

#endregion


#region limpeza

//Já usei a struct _verde, eu posso deletar ela
delete _personagem_verde;
delete _ameba_verde;
delete _ameba_vermelha;

#endregion

