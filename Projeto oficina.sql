show databases;
drop database oficina;
create database oficina;

use ecommerce;

create table clients(
	idClient int auto_increment primary key,
    nome varchar(15),
    sobrenome char(30),
    CPF char(11) not null,
    Adress varchar(30),
    constraint unique_cpf_client unique (CPF)
);

alter table client auto_increment=1;

create table veiculo(
	idVeiculo int auto_increment primary key,
    Modelo varchar(20) not null,
    Marca varchar(10) not null,
    idClient int not null,
    constraint fk_client_client foreign key (idClient) references clients(idClient)
);

create table pedido(
	idPedido int auto_increment primary key,
    descriçãoServiço varchar(255) not null,
    dataSolicitação date not null,
    liberado boolean not null,
    idPVeiculo int not null,
    constraint fk_pedido_veiculo foreign key (idPVeiculo) references veiculo(idVeiculo)
);

create table serviço(
	idServiço int auto_increment primary key,
    servico enum('Revisão', 'Manutenção') not null,
    idSPedido int not null,
    constraint fk_serviço_pedido foreign key (idSPedido) references pedido(idPedido)
);

create table ordemServiço(
	idOServiço int auto_increment primary key,
    statusOS enum('Aguardando Avaliação','Em avaliação', 'Em manutenção','Finalizado'),
    dataEmissão date not null,
    serviçoAutorizdo boolean not null,
    valor float not null,
    dataConclusão date not null,
    idOSServiço int not null,
    idOSPedido int not null,
    idOSClient int not null,
    constraint fk_OS_serviço foreign key (idOSServiço) references serviço(idServiço),
    constraint fk_OS_pedido foreign key (idOSPedido) references pedido(idPedido),
    constraint fk_OS_client foreign key (idOSClient) references clients(idClient)
);

create table mecanicos(
	idMecanicos int auto_increment primary key,
    nome varchar(30) not null,
    sobrenome varchar(50) not null,
    CPF char(11) not null,
    endereço varchar(130),
    especialidade enum('Lanterneiro','Eletricista','Mecanica') not null,
    constraint unique_cpf_client unique (CPF)
);

create table responsavel(
	idResponsavel int auto_increment primary key,
    idRMecanico int not null,
    constraint fk_responsavel_mecanico foreign key (idRMecanico) references mecanico(idMecanico)
);

create table pecas(
	idPecas int,
    idPreço float
);

create table fornecedor(
	idFornecedor int auto_increment primary key,
    nomeFornecedor varchar(100),
    CNPJ char(15) not null unique
);

create table analisePedido(
	idAPedido int,
    idRPedido int,
    primary key (idAPedido, idRPedido),
    constraint fk_analise_pedido foreign key (idAPedido) references pedido(idPedido),
    constraint fk_responsavel_pedido foreign key (idRPedido) references responsavel(idResponsavel)
);

create table pecasServico(
	idPSOS int,
    idPSPecas int,
    quantitdade int not null,
    primary key (idPSOS, idPSPecas),
    constraint fk_pecas_OS foreign key (idPSOS) references ordemServiço(idOServiço),
    constraint fk_pecas_pecas foreign key (idPSPecas) references pecas(idPecas)
);

show tables;

