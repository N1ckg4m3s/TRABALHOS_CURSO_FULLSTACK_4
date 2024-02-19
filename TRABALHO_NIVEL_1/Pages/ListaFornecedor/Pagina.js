import React, { useEffect, useState } from "react";
import {View, Button, FlatList,Text,TouchableOpacity, TextInput} from "react-native";
import CardLista from "../../Components/CardList";
import Estilo from "./Estilo"
import { FornecedorControlerCalled } from "../../Controle/FornecedorControle";
import { useFocusEffect } from "@react-navigation/native";

const ListaFornecedor = ({route,navigation}) => {
    const [ListFornecedor,SetListaFornecedor]=useState([])
    const [FilterResult,SetFilterResult]=useState([])

    const [Filter,SetFilter]=useState(false)
    const [Buscando,SetBuscando]=useState(false)
    
    const [FilterSearch,SetFilterSearch]=useState("")
    const [_,SetTexto]=useState(false) // UpdateScreen
    const GetData=async () => {
        if(Buscando && FilterSearch!=""){
            Fornecedores= await FornecedorControlerCalled.ObterPorPesquisa(FilterSearch)
            SetBuscando(false)
            SetFilter(false)
            SetTexto(Fornecedores & Fornecedores.length || 0)
            SetListaFornecedor(Fornecedores)
        }else if (!Buscando && FilterSearch==""){
            const Fornecedores= await FornecedorControlerCalled.ObterTodosFornecedores()
            SetTexto(Fornecedores.length || 0)
            SetListaFornecedor(Fornecedores)
        }
    }
    // useFocusEffect(()=>{console.log('Deu focus');GetData()})
    useFocusEffect(()=>{GetData()})
    useEffect(()=>{GetData()},[])
    return(
    <View style={{width:'100%',height:'100%'}}>
        {Filter &&
        <View style={Estilo.FilterBar}>
            <View style={Estilo.FilterBarFrame}>
                <View style={{display:'flex',flexDirection:'row'}}>
                    <TouchableOpacity style={{height:30,marginRight:5,}}
                        onPress={()=>SetFilter(false)}>
                        <Text style={[Estilo.Centralizar,Estilo.BotaoFechar,Estilo.Centralizar]}>X</Text>
                    </TouchableOpacity>
                    <Text style={[Estilo.Centralizar,{width:'90%',height:30}]}>FILTRAR</Text>
                </View>
                <View style={Estilo.FilterBarDiv}>
                    <TextInput value={FilterSearch} onChangeText={SetFilterSearch}
                        style={Estilo.FilterBarInput}></TextInput>
                    <TouchableOpacity style={[Estilo.FilterBarButton,Estilo.Centralizar]}
                        onPress={()=>{SetBuscando(true)}}>
                        <Text>SEARCH</Text>
                    </TouchableOpacity>
                </View>
                <Text>{
                    (FilterResult && Filter) &&
                    (FilterResult.length==1 && "1 resultado encontrado") ||
                    (FilterResult.length>1 && FilterResult.length+" resultados encontrados") ||
                    "Nenhum resultado encontrado"
                    }</Text>
            </View>
        </View>
        }
        <View style={Estilo.container}>
            <View style={Estilo.NavBar}>
                <Text style={[Estilo.NavSpan,Estilo.Centralizar]}>
                    {FilterSearch!=""&&"Buscando por: "+FilterSearch||"LISTA FORNECEDORES"}
                </Text>
                <TouchableOpacity style={[Estilo.NavButton,{height:'100%'}]}
                    onPress={()=>{SetFilter(true);SetBuscando(false)}}>
                    <Text style={[Estilo.Centralizar,{height:'100%',fontSize:11}]}>
                        FILTRAR
                    </Text>
                </TouchableOpacity>
            </View>
            {FilterSearch!=""&&<Text>{
                (FilterResult && Filter) &&
                (FilterResult.length==1 && "1 resultado encontrado") ||
                (FilterResult.length>1 && FilterResult.length+" resultados encontrados") ||
                "Nenhum resultado encontrado"
            }</Text>}
            <Button title="Adicionar Fornecedor" onPress={()=>navigation.navigate("CADASTRO_FORNECEDORES")}></Button>
            <View style={Estilo.main}>
                <FlatList
                    data={ListFornecedor}
                    renderItem={({ item }) => <CardLista
                        Nome={item.Nome}
                        Desc={item.Descricao}
                        Imag={item.Imagem}
                        Id={item.Id}
                        navigate={navigation}
                    ></CardLista>}
                />
            </View>
        </View>
    </View>)
}
export default ListaFornecedor;