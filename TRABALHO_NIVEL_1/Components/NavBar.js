import React from "react"
import { StyleSheet,View,Text, TouchableOpacity} from 'react-native';
const NavBar=(props)=>{
    return(
    <View style={Estilo.NavBar}>
        <TouchableOpacity style={Estilo.NavButton}
        onPress={()=>props.navigate.goBack()}>
            <Text style={[Estilo.Centralizar]}>X</Text>
        </TouchableOpacity>
        <Text style={[Estilo.NavSpan,Estilo.Centralizar]}>{props.Titulo}</Text>
    </View>
    )
}
const CoresStyle={
    'Black':'#000000',
    'White':'#ffffff',
    'PlaceHolder':'#7C7C7C',
    'BackColor':'#909090',
    'TopColor':'#d9d9d9'
  }
const Estilo=StyleSheet.create({
    NavBar:{
        width: '100%',
        height: 35,
        backgroundColor: CoresStyle.TopColor,
        padding: 5,
        display: 'flex',
        flexDirection: 'row',
        borderRadius: 8,
    },
    NavButton:{
        width: 25,
        height: 25,
        backgroundColor: CoresStyle.BackColor,
        borderRadius: 5,
    },
    NavSpan:{
        display: 'flex',
        justifyContent: 'center',
        alignItems: 'center',
        fontSize: 12,
        width: '92%',
        height: '100%',
        marginLeft: 5,
        borderRadius: 6,
        backgroundColor: CoresStyle.BackColor
    },
    Centralizar:{
        display:'flex',
        justifyContent:'center',
        alignItems:'center',
        textAlign:'center',
        textAlignVertical:'center'
    },
})
export default NavBar