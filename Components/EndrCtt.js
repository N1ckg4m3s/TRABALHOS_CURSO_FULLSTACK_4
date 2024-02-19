import React from "react"
import { StyleSheet,View,Text,TouchableOpacity } from 'react-native';
const EnderecoContato=(props)=>{
    return(
    <View style={Estilo.EndrContDiv}>
        <Text style={Estilo.EndrContSpan}> {props.Cidade} - {props.Uf} </Text>
        <Text style={Estilo.EndrContSpan}>{props.Rua},{props.Numero} - {props.Bairro}</Text>
        <View style={Estilo.hr}/>
        {props.Telefones.map((item,index)=>(<Text key={index}>{item}</Text>))}
        {props.BotsConfig && (<View style={Estilo.Botoes}>
            <TouchableOpacity style={[
                Estilo.Centralizar,
                Estilo.BotConfigBase,
                {backgroundColor:'#FF6161'}
                ]}
                onPress={props.RemoveEndereco}>
                <Text>X</Text>
            </TouchableOpacity>
            <TouchableOpacity style={[
                Estilo.Centralizar,
                Estilo.BotConfigBase,
                {backgroundColor:'#6184FF'}
                ]}
                onPress={props.EditEndereco}>
                <Text>🖊</Text>
            </TouchableOpacity>
        </View>)}
    </View>)
}

const CoresStyle={
    'Black':'#000000',
    'White':'#ffffff',
    'PlaceHolder':'#7C7C7C',
    'BackColor':'#909090',
    'TopColor':'#d9d9d9'
}
const Estilo=StyleSheet.create({
    EndrContSpan:{
        fontSize:12,
        marginBottom:5
    },
    EndrContDiv:{
        padding: 5,
        marginBottom: 5,
        borderRadius: 5,
        borderColor: '#000000',
        borderStyle: 'solid',
        borderWidth: .5,
        backgroundColor: CoresStyle.White,
    },
    hr:{
        borderBottomColor: 'black',
        borderBottomWidth: .5,
    },
    CategUi:{
        marginTop:5,
        marginRight:0,
        marginLeft:15,
        marginBottom:5,
    },
    Centralizar:{
        display:'flex',
        justifyContent:'center',
        alignItems:'center',
        textAlign:'center',
        textAlignVertical:'center'
    },
    BotConfigBase:{
        aspectRatio: '1/1',
        fontSize:20,
        borderRadius: 5,
        borderWidth:.5,
        borderColor:'#000000',
        width:25,
        marginRight:4
    },
    Botoes:{
        position:'absolute',
        top:5,
        right:0,
        display:'flex',
        flexDirection:'row'
    },
})
export default EnderecoContato