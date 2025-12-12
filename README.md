# Desafio do Paredão

Fui desafiado à criar um sistema full stack com um front e API para lidar com votos para um hipotético paredão do BBB, com alguns recursos de monitoramento.

## Instalação
Para instalar o sistema, você pode usar o `docker-compose` com o seguinte comando:

```bash
docker-compose up
```

## Uso

Após iniciado, você vai poder acessar os recursos com as seguintes rotas:

- Em `http://127.0.0.1:4200/` você encontra o Front End em Angular
- Em `http://127.0.0.1:3000/` você, por padrão, encontra o Dashboard de monitoramento da API
- Em `http://127.0.0.1:3000/voting/contestants` você encontra os participantes do paredão
- Em `http://127.0.0.1:3000/voting/total` você encontra o total de votos por participante

## Licença

[MIT](https://choosealicense.com/licenses/mit/)
