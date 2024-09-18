# 🕹️ Pokémon NFT com Blockchain Ethereum

Este projeto implementa um **NFT de Pokémon** utilizando **smart contracts** na blockchain **Ethereum**. O contrato foi inspirado no código do repositório do **Professor Cassiaone Peres** da (DIO), disponível [neste link](https://github.com/digitalinnovationone/formacao-blockchain-dio/blob/main/Modulo%2003%20Desenvolvimento%20com%20Solidity/Curso%2003%20O%20mercado%20de%20blockchain%20e%20criptomoedas/Crie%20o%20seu%20NFT%20de%20Pokemon%20com%20Blockchain/PokeDIO.sol). Novas funcionalidades foram adicionadas, como a criação de novos Pokémons e a listagem de todos os IDs existentes.

## 🎯 Objetivo

O objetivo do projeto é criar um contrato inteligente que permita a criação e o gerenciamento de NFTs de Pokémons, onde cada Pokémon é representado por um token **ERC-721**. O dono do contrato pode criar novos Pokémons, realizar batalhas entre eles ou pode cruzar seus Pokémons para gerar novos.

---

## 🔧 Ferramentas Utilizadas

1. **Solidity**: Linguagem usada para escrever o contrato inteligente na blockchain Ethereum.
2. **ChainIDE**: Plataforma de desenvolvimento online usada para compilar e implementar o contrato.
  - [Link para o ChainIDE](https://chainide.com/)
   
3. **Ganache**: Blockchain local para testar contratos inteligentes.
  - [Link para o Ganache](https://archive.trufflesuite.com/ganache/)
   
4. **MetaMask**: Carteira digital para interagir com a blockchain e gerenciar os NFTs.
  - [Link para o MetaMask](https://metamask.io/)
   
5. **Pixlr**: Ferramenta para gerar as imagens dos Pokémons.
  - [Link para o Pixlr](https://pixlr.com/br/image-generator/)
   
6. **IPFS**: Utilizado para armazenar as imagens dos Pokémons.
  - [Link para o Pixlr](https://ipfs.tech/)

---

## 🛠 Funcionalidades do Contrato

### Estrutura do NFT

- **Nome do Token**: PokémonSOL

### Funções Principais

1. **NFTs de Pokémon**: Cada Pokémon é um NFT seguindo o padrão ERC721, que pode ser negociado e transferido.
2. **Criação de Pokémons**: Apenas o dono do jogo pode criar novos Pokémons.
3. **Batalhas e Evolução**: Pokémons podem batalhar e evoluir seus níveis com base nas batalhas.
4. **Cruzamento**: Dois Pokémons podem cruzar para criar um novo, com características herdadas dos pais.
5. **Lista de Pokémons**: Qualquer pessoa pode visualizar os Pokémons criados.

### Estrutura do Pokémon

Cada Pokémon possui:
- **name**: Nome do Pokémon.
- **level**: Nível do Pokémon, que aumenta com batalhas.
- **img**: URL da imagem do Pokémon.

---

## 📋 Estrutura do Projeto

### 1. Array de Pokémons

O contrato armazena os Pokémons em um array público chamado `pokemons`, que permite o acesso e visualização de todos os NFTs criados.

### 2. Proprietário do Jogo (Game Owner)

O contrato possui uma variável `gameOwner` que armazena o endereço do proprietário do jogo, definido no momento da implantação do contrato. Apenas o proprietário pode criar novos Pokémons.

### 3. Modificador `onlyOwnerOf`

Este modificador verifica se o chamador da função é o proprietário de um determinado Pokémon (identificado pelo `monsterId`). Isso garante que somente o dono de um Pokémon pode realizar certas ações, como batalhar ou cruzar.

### 4. Função `battle`

Permite que dois Pokémons batalhem entre si. Apenas os proprietários dos Pokémons podem iniciar a batalha. Após a batalha, o nível dos Pokémons é ajustado:
- O Pokémon com o nível mais alto ganha **2 níveis**.
- O Pokémon perdedor ganha **1 nível**.
- Em caso de empate, ambos ganham **1 nível**.

### 5. Função `createNewPokemon`

O dono do jogo pode criar novos Pokémons com um nome, uma imagem e atribuí-los a um jogador especificado. Cada novo Pokémon é adicionado ao array e um novo NFT é mintado para o endereço do jogador.

### 6. Função `breedPokemon`

Esta função permite que dois Pokémons sejam cruzados para criar um novo Pokémon, cujos níveis são a média dos níveis dos pais e sua imagem é uma combinação das imagens dos pais.

### 7. Função `getPokemon`

Retorna os detalhes de um Pokémon específico, incluindo nome, nível e URL da imagem, utilizando o ID do NFT.

### 8. Função `listAllPokemonIds`

Essa função retorna um array contendo os IDs de todos os Pokémons criados no jogo, permitindo listar todos os NFTs existentes.

---

## 🚀 Segue o Passo a Passo para Executar o Projeto

### 1. Compilar e Implantar o Contrato

1. Acesse o **ChainIDE** e crie um novo projeto.
2. Insira o código do contrato **SOLpokemon.sol** no editor.
3. Conecte sua carteira **MetaMask** ao **Ganache** ou a uma rede de testes Ethereum.
4. Compile o contrato e faça o deploy na rede de testes.

### 2. Testar no Ganache

1. Inicie o **Ganache** para simular uma blockchain local.
2. Após o deploy, use **MetaMask** para interagir com o contrato e testar a criação de novos Pokémons.
3. Crie as imagens dos Pokémons com **Pixlr** e armazene-as no **IPFS**. Use os links das imagens ao criar novos Pokémons.
4. Teste funções como `createNewPokemon`, `battle` e `breedPokemon` no **ChainIDE** ou diretamente pelo **MetaMask**.

### 3. Gerar e Gerenciar NFTs

1. Utilize a função `createNewPokemon` para criar e atribuir Pokémons NFTs a diferentes endereços.
2. Liste todos os NFTs criados com a função `listAllPokemonIds`.
3. Sinta-se à vontade para modificar o contrato e adicionar novas funcionalidades.

## 📚 Referências

- **ERC-721**: [Entenda o padrão ERC-721 para NFTs](https://ethereum.org/en/developers/docs/standards/tokens/erc-721/)
- **MetaMask**: [Documentação oficial do MetaMask](https://docs.metamask.io/)
- **ChainIDE**: [Guia do ChainIDE](https://chainide.gitbook.io/chainide/)
- **Ganache**: [Documentação do Ganache](https://trufflesuite.com/docs/ganache/)
