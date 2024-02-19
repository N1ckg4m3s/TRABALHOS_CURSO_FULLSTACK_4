import React from "react"
import { Image, StyleSheet, View, Text, TouchableOpacity } from 'react-native';
const CardLista=(props)=>{
    return(
    <TouchableOpacity style={[Estilo.MainDiv, Estilo.Img_Nome]}
    onPress={()=>props.navigate.navigate("DADOS_FORNECEDORES",props.Id)}>
        <Image style={Estilo.Img_Nome_Imagem}
        source={{uri: props.Imag || "data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7"}}/>
        <View style={Estilo.Img_Nome_Div}>
            <Text style={Estilo.Img_Nome_Div_Nome}>{props.Nome}</Text>
            <Text style={Estilo.Img_Nome_Div_Descricao}>{props.Desc}</Text>
        </View>
    </TouchableOpacity>)
}
const CoresStyle={
    'Black':'#000000',
    'White':'#ffffff',
    'PlaceHolder':'#7C7C7C',
    'BackColor':'#909090',
    'TopColor':'#d9d9d9'
  }
const Estilo=StyleSheet.create({
    MainDiv:{
        padding: 5,
        marginBottom: 5,
        borderColor: 'Black',
        borderStyle: 'solid',
        borderWidth: .5,
        backgroundColor: CoresStyle.White,
        borderRadius:5
    },
    Img_Nome:{
        padding:5,
        marginBottom: 5,
        borderColor: 'transparent',
        backgroundColor: CoresStyle.BackColor,
        width: '100%',
        height: 120,
        display: 'flex',
        flexDirection:'row'
    },
    Img_Nome_Imagem:{
        width: 110,
        height: 110,
        borderRadius: 5,
        backgroundColor: CoresStyle.White,
    },
    Img_Nome_Div:{
        marginLeft: 5,
        display: 'flex',
        flexDirection: 'column',
        width: '67.5%',
    },
    Img_Nome_Div_Nome:{
        width: 'auto',
        height:25,
        marginBottom:5,
        borderRadius: 5,
        borderColor: '#000000',
        borderStyle: 'solid',
        borderWidth: .5,
        backgroundColor: CoresStyle.White,
     },
    Img_Nome_Div_Descricao:{
        width: 'auto',
        height:81,
        borderRadius: 5,
        borderColor: '#000000',
        borderStyle: 'solid',
        borderWidth: .5,
        backgroundColor: CoresStyle.White,
    },
})
export default CardLista