import React, { useEffect, useState } from "react"
import {View,Text,Image,FlatList, TouchableOpacity} from "react-native"
import Estilo from "./Estilo"
import EnderecoContato from "../../Components/EndrCtt"
import { FornecedorControlerCalled } from "../../Controle/FornecedorControle"
import NavBar from "../../Components/NavBar"
import { useFocusEffect } from "@react-navigation/native"

const DadosFornecedor = ({ route,navigation }) => {
    const Id=route.params
    
    const [Nome,SetNome]=useState("") 
    const [Descricao,SetDescricao]=useState("")
    const [Imagem,SetImagem]=useState("")
    
    const [Categorias,SetCategoria]=useState([])
    const [Endereco,SetEndereco]=useState({})
    const ObterDados=async ()=>{
        const AllData= await FornecedorControlerCalled.ObterPorID(Id)
        SetNome(AllData.Nome)
        SetDescricao(AllData.Descricao)
        SetImagem(AllData.Imagem)
        SetCategoria(AllData.Categorias)
        SetEndereco(AllData.Enderecos)
    }
    useFocusEffect(()=>{ObterDados()})
    useEffect(()=>{ObterDados()},[])
    return(
    <View style={[Estilo.container]}>
    <NavBar Titulo={`Dados ${Nome}`} navigate={navigation}/>
        <TouchableOpacity style={[Estilo.EditDataButton,Estilo.Centralizar]}
            onPress={()=>navigation.navigate("CADASTRO_FORNECEDORES",Id)}>
            <Text style={[Estilo.EditDataText,Estilo.Centralizar,{fontSize:11}]}>EDITAR INFORMAÇOES</Text>
        </TouchableOpacity>
        <View style={Estilo.main}>
            <View style={[Estilo.MainDiv, Estilo.Img_Nome]}>
                <Image
                source={{uri:Imagem || "data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7"}}
                style={Estilo.Img_Nome_Imagem}/>
                <View style={Estilo.Img_Nome_Div}>
                    <Text style={Estilo.Img_Nome_Div_Nome}>{Nome}</Text>
                    <Text style={Estilo.Img_Nome_Div_Descricao}>{Descricao}</Text>
                </View>
            </View>
            <View style={Estilo.MainDiv}>
                <Text style={Estilo.CategSpan}>CATEGORIA LIST</Text>
                <FlatList
                    style={Estilo.CategUi}
                    data={Categorias}
                    renderItem={({ item }) => <Text style={Estilo.CategLi}>{item}</Text>}
                    keyExtractor={(item) => Categorias.findIndex((Itm)=>Itm==item)}
                />
            </View>
            <View style={Estilo.MainDiv}>
                <Text style={Estilo.CategSpan}>ENDEREÇO/CONTATO LIST</Text>
                <FlatList
                    style={Estilo.CategUi}
                    data={Endereco}
                    renderItem={({ item }) => <EnderecoContato
                        Rua={item.Rua}
                        Numero={item.Numero}
                        Bairro={item.Bairro}
                        Cidade={item.Cidade}
                        Uf={item.Uf}
                        Telefones={item.Telefones}
                        BotsConfig={false}
                        />}
                    keyExtractor={(item)=>Endereco.findIndex((item2)=>item2==item)}
                />
            </View>
        </View>
    </View>)
}
export default DadosFornecedor

/*

*/