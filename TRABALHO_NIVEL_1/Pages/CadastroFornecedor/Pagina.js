import React, { useEffect, useState } from "react"
import * as ImagePicker from "expo-image-picker"
import {View,TouchableOpacity,Text,TextInput,Button,Alert,Image} from "react-native"
import Estilo from "./Estilo"
import NavBar from "../../Components/NavBar"
import EnderecoContato from "../../Components/EndrCtt"
import { FornecedorControlerCalled } from "../../Controle/FornecedorControle"
const CadastroFornecedor = ({route,navigation}) => {
    const Id=route.params
    const [Nome,SetNome]=useState("")
    const [Descricao,SetDescricao]=useState("")
    const [Imagem,SetImagem]=useState(null)
    const [Categ,SetCateg]=useState("")
    const [Telef,SetTelef]=useState("")

    const [Categorias,SetCategoria]=useState([])
    const [Telefones,SetTelefones]=useState([])
    const [Endereco,SetEndereco]=useState([])

    const [Rua,SetRua]=useState("")
    const [Numero,SetNumero]=useState("")
    const [Bairro,SetBairro]=useState("")
    const [Cidade,SetCidade]=useState("")
    const [Uf,SetUf]=useState("")
    
    const [EditandoIndex,SetEditandoIndex]=useState("NADA")

    useEffect(()=>{
        if(Id){
            const GetData= async()=>{
                let AllData=await FornecedorControlerCalled.ObterPorID(Id)
                SetNome(AllData.Nome)
                SetDescricao(AllData.Descricao)
                SetImagem(AllData.Imagem)
                SetCategoria([...AllData.Categorias])
                SetEndereco([...AllData.Enderecos])
            }
            GetData()
        }
    },[])

    function adicionarCategoria(){
        if(Categ!=""){
            if(Categorias.indexOf(Categ)){
                SetCategoria([...Categorias,Categ])
                SetCateg("")
            }
        }else{
            Alert.alert("Preencha o campo antes de tentar adicionar")
        }
    }
    function adicionarTelefone(){
        if(Telef!=""){
            if(Telefones.indexOf(Telef)){
                SetTelefones([...Telefones,Telef])
                SetTelef("")
            }
        }else{
            Alert.alert("Preencha o campo antes de tentar adicionar")
        }
    }
    function adicionarEndereco(){
        SetEditandoIndex("NADA")
        if(Rua!="" & Numero!="" & Bairro!="" & Cidade!="" & Uf!="" & Telefones!=[]){
            SetEndereco([
            ... Endereco,{
                Rua:Rua,
                Numero:Numero,
                Bairro:Bairro,
                Cidade:Cidade,
                Uf:Uf,
                Telefones:Telefones,
            }])
            SetRua("")
            SetNumero("")
            SetBairro("")
            SetCidade("")
            SetUf("")
            SetTelefones([])
        }else{
            Alert.alert("Preencha os campos antes de tentar adicionar")
        }
    }
    function Finalizar(){
        if(Nome!="" & Descricao!="" & Imagem!="" & Categorias!=[] & Endereco!=[]){
            const AllData=FornecedorControlerCalled.ObterPorID(Id)
            AllData.Nome=Nome
            AllData.Descricao=Descricao
            AllData.Imagem=Imagem
            AllData.Categorias=Categorias
            AllData.Endereco=Endereco
            SetNome("")
            SetDescricao("")
            SetImagem("")
            SetCategoria([])
            SetEndereco([])
        }else{
            Alert.alert("Preencha os campos antes de tentar adicionar")
        }
    }
    const SelecImage = async () => {
        const { status } = await ImagePicker.requestMediaLibraryPermissionsAsync()
        if (status !== 'granted') {
            Alert.alert('Permissão necessária', 'Você precisa conceder permissão para acessar a biblioteca de mídia.')
            return
        }
        const result = await ImagePicker.launchImageLibraryAsync({
            mediaTypes: ImagePicker.MediaTypeOptions.Images,
            allowsEditing: true,
            aspect: [1,1],
            quality: 1,
        })
        if (!result.cancelled) {
            SetImagem(result.assets[0].uri)
        }
    }

    const RemoveEndereco=(index)=>{
        const NovaLista=Endereco.pop(index)
        SetEndereco([NovaLista])
    }
    const EditEndereco=(index)=>{
        SetRua(Endereco[index].Rua)
        SetNumero(Endereco[index].Numero)
        SetBairro(Endereco[index].Bairro)
        SetCidade(Endereco[index].Cidade)
        SetUf(Endereco[index].Uf)
        SetTelefones(Endereco[index].Telefones)
        RemoveEndereco(index)
        SetEditandoIndex(index)
    }

    const RemoveTelefone=(index)=>{
        const NovaLista=Telefones.pop(index)
        SetTelefones(NovaLista)
    }

    const RemoveCategoria=(index)=>{
        const NovaLista=Categorias.pop(index)
        SetCategoria(NovaLista)
    }
    return(
    <View style={Estilo.container}>
        <NavBar Titulo={Id && "Modificar dados" ||"Cadastrar"} navigate={navigation}/>
        <View style={Estilo.Main}>
            <View style={[Estilo.Img_Nome]}>
                <TouchableOpacity onPress={() => SelecImage()}>
                    {
                        (Imagem!=null && Imagem!="") &&
                        <Image style={Estilo.Img_Nome_Imagem} source={{uri:Imagem}}/> || 
                        <Text style={[Estilo.Img_Nome_Imagem,Estilo.Centralizar,{zIndex:2,color:'black'}]}>SELECT{'\n'}IMAGE</Text>
                    }
                </TouchableOpacity>
                <View style={Estilo.Img_Nome_Div}>
                    <TextInput value={Nome} onChangeText={SetNome} style={Estilo.Img_Nome_Div_Nome} placeholder="NOME" />
                    <TextInput value={Descricao} onChangeText={SetDescricao} style={Estilo.Img_Nome_Div_Descricao} placeholder="DESCRIÇÃO" />
                </View>
            </View>
            <View style={Estilo.MainDiv}>
                <View style={Estilo.CategDiv}>
                    <TextInput value={Categ} onChangeText={SetCateg} style={Estilo.CategInput} placeholder="CATEGORIA" />
                    <TouchableOpacity style={Estilo.CategInputButton} onPress={() => adicionarCategoria()}>
                        <Text style={Estilo.Centralizar}>+</Text>
                    </TouchableOpacity>
                </View>
                {Categorias.map((item,index)=>(
                    <View key={index} style={{display:'flex',flexDirection:'row'}}>
                        <Text style={Estilo.CategLi}>{item}</Text>
                        <TouchableOpacity onPress={()=>RemoveCategoria(index)} style={[
                            Estilo.BotConfigBase,
                            Estilo.Botoes,
                            Estilo.Centralizar,
                            {backgroundColor:'#FF6161',width:25}
                            ]}>
                            <Text style={Estilo.Centralizar}>X</Text>
                        </TouchableOpacity>
                    </View>
                ))}
            </View>
            <View style={Estilo.MainDiv}>
                <Text style={Estilo.CategSpan}>ENDEREÇO/CONTATO LIST</Text>
                {Endereco.map((item,index)=>(
                    <EnderecoContato
                    key={index}
                    Rua={item.Rua}
                    Numero={item.Numero}
                    Bairro={item.Bairro}
                    Cidade={item.Cidade}
                    Uf={item.Uf}
                    Telefones={item.Telefones}
                    BotsConfig={true}
                    EditEndereco={()=>EditEndereco(index)}
                    RemoveEndereco={()=>RemoveEndereco(index)}
                    />
                ))}
                <View>
                    <View style={{display:'flex',flexDirection:'row'}}>
                        <TextInput style={[Estilo.Input,{
                            height:25,
                            width: '73.5%',
                            marginRight:5,
                            fontSize: 10
                            }]}
                            value={Rua}
                            onChangeText={SetRua}
                            placeholder="ENDEREÇO"/>
                        <TextInput style={[Estilo.Input,{
                            height:25,
                            width: '25%',
                            marginRight:5,
                            fontSize: 10
                            }]}
                            value={Numero}
                            onChangeText={SetNumero}
                            placeholder="NUMERO"
                            keyboardType="numeric"/>
                    </View>
                    <View style={{display:'flex',flexDirection:'row',justifyContent:'space-between'}}>
                        <TextInput style={[Estilo.Input,{
                            height:25,
                            width: '32.3%',
                            marginRight:5,
                            fontSize: 10
                            }]}
                            value={Bairro}
                            onChangeText={SetBairro}
                            placeholder="BAIRRO"/>
                        <TextInput style={[Estilo.Input,{
                            height:25,
                            width: '32.3%',
                            marginRight:5,
                            fontSize: 10
                            }]}
                            value={Cidade}
                            onChangeText={SetCidade}
                            placeholder="CIDADE"/>
                        <TextInput style={[Estilo.Input,{
                            height:25,
                            width: '32.3%',
                            marginRight:5,
                            fontSize: 10
                            }]}
                            value={Uf}
                            onChangeText={SetUf}
                            placeholder="UF"
                            maxLength={2}/>
                    </View>
                </View>
                <View style={Estilo.hr}/>
                <View style={Estilo.CategDiv}>
                    <TextInput
                    value={Telef}
                    onChangeText={text => SetTelef(text.replace(/[^0-9]/g, ''))}
                    style={Estilo.CategInput}
                    placeholder="TELEFONE"
                    keyboardType="number-pad"
                    maxLength={11}/>
                    <TouchableOpacity onPress={() => adicionarTelefone()} style={Estilo.CategInputButton}>
                        <Text style={Estilo.Centralizar}>+</Text>
                    </TouchableOpacity>
                </View>
                {Telefones.map((item,index)=>(
                    <View key={index} style={{display:'flex',flexDirection:'row'}}>
                        <Text style={Estilo.CategLi}>{item}</Text>
                        <TouchableOpacity onPress={()=>RemoveTelefone(index)} style={[
                            Estilo.BotConfigBase,
                            Estilo.Botoes,
                            Estilo.Centralizar,
                            {backgroundColor:'#FF6161',width:25}
                            ]}>
                            <Text style={Estilo.Centralizar}>X</Text>
                        </TouchableOpacity>
                    </View>
                ))}
                <Button onPress={()=>adicionarEndereco()} title={`${EditandoIndex!="NADA"&&"MODIFICAR"||"ADICIONAR"} ENDEREÇO`}></Button>
            </View>
            <Button onPress={()=>Finalizar()} title={Id&&"SALVAR"||"FINALIZAR"}></Button>
        </View>
    </View>)
}
export default CadastroFornecedor