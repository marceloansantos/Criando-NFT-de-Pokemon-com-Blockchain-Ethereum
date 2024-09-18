// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.1;

// Importa o contrato ERC721 da OpenZeppelin
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.7.0/contracts/token/ERC721/ERC721.sol";

contract PokemonSOL is ERC721 {

    // Definição da estrutura para armazenar dados dos Pokémons
    struct Pokemon {
        string name;  // Nome do Pokémon
        uint level;   // Nível do Pokémon
        string img;   // URL da imagem do Pokémon
    }

    // Array público de todos os Pokémons criados
    Pokemon[] public pokemons;
    
    // Endereço do dono do jogo (que pode criar novos Pokémons)
    address public gameOwner;

    // Construtor para inicializar o dono do jogo e o contrato ERC721
    constructor() ERC721("PokemonSOL", "PKS") {
        gameOwner = msg.sender;  // O dono do jogo é o endereço que cria o contrato
    }

    // Modificador que verifica se o chamador é o dono de um Pokémon específico
    modifier onlyOwnerOf(uint _monsterId) {
        require(_exists(_monsterId), "ERC721: token ID invalido");  // Verifica se o token existe
        require(ownerOf(_monsterId) == msg.sender, "Apenas o dono pode utilizar este Pokemon");  // Verifica se o chamador é o dono do Pokémon
        _;
    }

    // Função para realizar batalhas entre dois Pokémons
    function battle(
        uint _attackingPokemon,
        uint _defendingPokemon
    ) public onlyOwnerOf(_attackingPokemon) onlyOwnerOf(_defendingPokemon) {
        // Verifica se os IDs dos Pokémons atacante e defensor existem
        require(_exists(_attackingPokemon), "Pokemon atacante nao existe");
        require(_exists(_defendingPokemon), "Pokemon defensor nao existe");

        // Acessa os dados dos Pokémons atacante e defensor
        Pokemon storage attacker = pokemons[_attackingPokemon];
        Pokemon storage defender = pokemons[_defendingPokemon];

        // Atualiza o nível dos Pokémons com base no resultado da batalha
        if (attacker.level >= defender.level) {
            attacker.level += 2;
            defender.level += 1;
        } else {
            attacker.level += 1;
            defender.level += 2;
        }
    }

    // Função para criar um novo Pokémon e mintar um NFT para um jogador
    function createNewPokemon(
        string memory _name,
        address _to,
        string memory _img
    ) public {
        // Verifica se o chamador é o dono do jogo
        require(msg.sender == gameOwner, "Apenas o dono do jogo pode criar novos Pokemons");

        // Adiciona o novo Pokémon ao array e mint um novo NFT
        uint id = pokemons.length;
        pokemons.push(Pokemon(_name, 1, _img));  // Nível inicial é 1
        _safeMint(_to, id);  // Cria o token NFT e atribui ao endereço "_to"
    }

    // Função para cruzar dois Pokémons e criar um novo
    function breedPokemon(
        uint _parent1Id,
        uint _parent2Id,
        string memory _newPokemonName
    ) public onlyOwnerOf(_parent1Id) onlyOwnerOf(_parent2Id) {
        // Verifica se os pais são diferentes e se ambos existem
        require(_parent1Id != _parent2Id, "Os pais devem ser diferentes");
        require(_exists(_parent1Id), "Pokemon pai 1 nao existe");
        require(_exists(_parent2Id), "Pokemon pai 2 nao existe");

        // Acessa os dados dos Pokémons pais
        Pokemon storage parent1 = pokemons[_parent1Id];
        Pokemon storage parent2 = pokemons[_parent2Id];

        // O nível do novo Pokémon será a média dos níveis dos pais
        uint newLevel = (parent1.level + parent2.level) / 2;

        // Gera a nova imagem concatenando as URLs das imagens dos pais
        string memory newImg = string(abi.encodePacked(parent1.img, "-", parent2.img));

        // Adiciona o novo Pokémon ao array e mint um novo NFT para o chamador
        uint newId = pokemons.length;
        pokemons.push(Pokemon(_newPokemonName, newLevel, newImg));
        _safeMint(msg.sender, newId);  // Mint do novo Pokémon
    }

    // Função para obter os detalhes de um Pokémon específico
    function getPokemon(
        uint _pokemonId
    ) public view returns (string memory name, uint level, string memory img) {
        // Verifica se o Pokémon existe
        require(_exists(_pokemonId), "Pokemon nao existe");

        // Retorna os detalhes do Pokémon
        Pokemon memory pokemon = pokemons[_pokemonId];
        return (pokemon.name, pokemon.level, pokemon.img);
    }

  // Função para listar todos os IDs de tokens criados (Pokémons mintados)
    function listAllPokemonIds() public view returns (uint[] memory) {
    uint totalPokemons = pokemons.length;  // Obtém o número total de Pokémons criados
    uint[] memory ids = new uint[](totalPokemons);  // Cria um array para armazenar os IDs

    // Preenche o array com os IDs de todos os Pokémons
    for (uint i = 0; i < totalPokemons; i++) {
        ids[i] = i;
    }

    return ids;  // Retorna o array com todos os IDs

    }
}
