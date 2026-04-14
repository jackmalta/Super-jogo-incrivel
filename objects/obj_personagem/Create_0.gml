/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor


#region variaveis

#endregion

#region inicia estados
estado_vazio = new estado();
estado_preenche = new estado();
estado_cheio = new estado();
#endregion

#region estados

#region estado_vazio
estado_vazio.inicia = function()
{
    sprite_index = spr_personagem_vazio;
}

#endregion

#region estado preenche
estado_preenche.inicia = function()
{
    sprite_index = spr_personagem_enche;
    image_index  = 0;
}

estado_preenche.roda = function()
{
    //Se a animação acabou, eu troco de estado
    if (image_index >= image_number - 1)
    {
        troca_estado(estado_cheio);
    }
}

#endregion

#region estado_cheio
estado_cheio.inicia = function()
{
    sprite_index = spr_personagem_cheio;
}

#endregion

#endregion

#region metodos

#endregion

inicia_estado(estado_vazio);