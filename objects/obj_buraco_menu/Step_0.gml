/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor
//Se eu estou ativo, eu vou para a room destino
if (ativo)
{
    //Só vou se a room existe
    if (room_exists(destino))
    {
        room_goto(destino);
        ativo = false;
    }
}