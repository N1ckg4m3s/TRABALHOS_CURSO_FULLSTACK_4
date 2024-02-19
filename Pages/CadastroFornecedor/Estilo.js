import { StyleSheet } from 'react-native';
const CoresStyle={
  'Black':'#000000',
  'White':'#ffffff',
  'PlaceHolder':'#7C7C7C',
  'BackColor':'#909090',
  'TopColor':'#d9d9d9'
}

const styles = StyleSheet.create({
  Centralizar:{
    display:'flex',
    justifyContent:'center',
    alignItems:'center',
    textAlign:'center',
    textAlignVertical:'center'
  },
  container:{
    margin:10,
    marginTop:25,
    padding:0
  },
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
  
  Main:{
    backgroundColor: CoresStyle.BackColor,
    margin:5,
    padding:5,
    display:'flex',
    flexDirection:'column',
    borderRadius:5
  },
  Input:{
    borderWidth:.5,
    paddingLeft:10,
    borderStyle:'solid',
    backgroundColor: CoresStyle.White,
    borderRadius:5,
    marginBottom: 5,
    width:'inherit',
    fontSize: 10,
  },
  CategUi:{
    marginTop:5,
    marginRight:0,
    marginLeft:15,
    marginBottom:5,
  },
  CategLi:{
    fontSize:12,
    height:35,
    textAlignVertical:'center',
    width:'100%',
  },
  MainDiv:{
    padding: 5,
    marginBottom: 5,
    borderColor: 'Black',
    borderStyle: 'solid',
    borderWidth: .5,
    backgroundColor: CoresStyle.White,
    borderRadius:5
  },
  CategDiv:{
    width: '100%',
    height: 30,
    display: 'flex',
    position: 'relative',
  },
  CategInput:{
    width: '100%',
    height: 25,
    paddingTop:0,
    paddingRight:25,
    paddingBottom:0,
    paddingLeft:5,
    fontSize: 10,
    borderColor: '#000000',
    borderStyle: 'solid',
    borderWidth: .5
  },
  CategInputButton:{
    position: 'absolute',
    top: 2,
    right: 2,
    width: 21,
    height: 21,
    backgroundColor: CoresStyle.White,
    borderColor: 'Black',
    borderStyle: 'solid',
    borderWidth: .5,
    borderRadius:5
  },
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
    marginBottom:5,
    marginTop:0
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
  Img_Nome:{
    backgroundColor:'red',
    borderColor: 'transparent',
    backgroundColor: CoresStyle.BackColor,
    width: '100%',
    height: 115,
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
      width: '66.75%',
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
});

export default styles;
