class FornecedorControler{
    FornecedoesList=[]
    ObterTodosFornecedores(){
        return this.FornecedoesList
    }
    AdicionarFornecedor(Forn){
        Forn.Id=this.FornecedoesList.length+1
        this.FornecedoesList.push(Forn)
    }
    RemoverFornecedor(Id){
        const index = this.FornecedoesList.findIndex((Forn) => Forn.Id === Id);
        if (index !== -1) {
            this.FornecedoesList.splice(index, 1);
        }
    }
    ObterPorID(Busca){
        const Result=this.FornecedoesList.find((Forn)=>Forn.Id==Busca)
        return Result
    }
    ObterPorPesquisa(Busca){
        console.log(Busca)
        var Result=[]
        for(Vlr in this.FornecedoesList){
            Forn=this.FornecedoesList[Vlr]
            var Adicionou=false
            if(Forn.Nome.includes(Busca)){
                Result.push(Forn)
                continue
            }
            for(Categ in Forn.Categorias){
                Categ=Forn.Categorias[Categ]
                if(Categ.includes(Busca)){
                    Result.push(Forn);Adicionou=true;break
                }
            }
            if(Adicionou){continue}
            for(Endr in Forn.Enderecos){
                Endr=Forn.Enderecos[Endr]
                if(Endr.Bairro.includes(Busca) ||
                    Endr.Cidade.includes(Busca) ||
                    Endr.Uf.includes(Busca)){
                    Result.push(Forn);break
                }
            }
        }
        console.log(Result.length)
        return Result
    }
    constructor(){}
}
export default FornecedorControler
export const FornecedorControlerCalled=new FornecedorControler()