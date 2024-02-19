import { FornecedorControlerCalled } from "./FornecedorControle"
import Fornecedores from "./Fornecedores"

const Categorias=["Frutas","Verduras","Madeira","Fazenda","Casa","Construção","Saude","Posto"]
const Bairros=["Ouro","Verde","Rosa","Fazenda","Casinha","Burraco","Saude","Posto"]
const Ufs=["BA","SP","VW","XP","H5","JJ","A2","54"]


export default DataTeste => {
    console.log("gerar data teste")
    for(i=0;i<10;i++){
        Categescolhida=[]
        for(i2=0;i2<2;i2++){
            var Choice=Categorias[Math.floor(Math.random()*8)]
            if(Categescolhida.indexOf(Choice)){
                Categescolhida.push(Choice)
            }
        }
        FornecedorControlerCalled.AdicionarFornecedor(
            new Fornecedores(
                "FORNECEDOR "+i,
                "DESCRIÇÃO",
                "",
                Categescolhida,
                [{
                    Rua:"NÃO IMP 1",
                    Numero:Math.floor(Math.random()*1000),
                    Bairro:Bairros[Math.floor(Math.random()*8)],
                    Cidade:Bairros[Math.floor(Math.random()*8)],
                    Uf:Ufs[Math.floor(Math.random()*8)],
                    Telefones:["NÃO IMP 1","NÃO IMP 2"],
                },
                {
                    Rua:"NÃO IMP 2",
                    Numero:Math.floor(Math.random()*1000),
                    Bairro:Bairros[Math.floor(Math.random()*8)],
                    Cidade:Bairros[Math.floor(Math.random()*8)],
                    Uf:Ufs[Math.floor(Math.random()*8)],
                    Telefones:["NÃO IMP 1","NÃO IMP 2"],
                },
            ])
        )
    }
}