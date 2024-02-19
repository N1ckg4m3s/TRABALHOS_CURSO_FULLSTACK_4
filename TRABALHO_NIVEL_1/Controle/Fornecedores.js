export default class Fornecedores{
    Id=""
    Nome=""
    Descricao=""
    Imagem=""
    Categorias=[]
    Enderecos=[]
    constructor(Nome,Dscr,Img,Categorias,Enderecos){
        this.Nome=Nome
        this.Descricao=Dscr
        this.Imagem=Img
        this.Categorias=Categorias
        this.Enderecos=Enderecos
    }
}
/*
Categorias=[
    "TESTE",
    "TESTE"
]
Enderecos=[
    [
        Rua="RUA TESTE",
        Numero="0",
        Bairro="BAIRRO",
        Cidade="CIDADE",
        Uf="ZZ",
        Telefones=[
            "(##) # ####-####"
        ],
    ]
]
*/