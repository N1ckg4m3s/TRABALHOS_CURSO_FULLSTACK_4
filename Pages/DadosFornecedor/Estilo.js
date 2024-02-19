import { StyleSheet } from 'react-native';

const CoresStyle={
  'Black':'#000000',
  'White':'#ffffff',
  'PlaceHolder':'#7C7C7C',
  'BackColor':'#909090',
  'TopColor':'#d9d9d9'
}

const styles = StyleSheet.create({
  container:{
    margin:10,
    marginTop:25,
    padding:0,
    display:'flex',
  },
  Centralizar:{
    display:'flex',
    justifyContent:'center',
    alignItems:'center',
    textAlign:'center',
    textAlignVertical:'center'
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
  
  main:{
    backgroundColor: CoresStyle.BackColor,
    margin: 5,
    padding: 5,
    display: 'flex',
    flexDirection: 'column',
    borderRadius: 5,
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
  Img_Nome:{
    padding:0,
    marginBottom: 5,
    borderColor: 'transparent',
    backgroundColor: CoresStyle.BackColor,
    width: '100%',
    height: 120,
    display: 'flex',
    flexDirection:'row'
  },
  Img_Nome_Imagem:{
    width: 120,
    height: 120,
    borderRadius: 5,
    backgroundColor: CoresStyle.White,
  },
  Img_Nome_Div:{
    marginLeft: 5,
    display: 'flex',
    flexDirection: 'column',
    width: '63.5%',
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
    height:91,
    borderRadius: 5,
    borderColor: '#000000',
    borderStyle: 'solid',
    borderWidth: .5,
    backgroundColor: CoresStyle.White,
  },
  CategSpan:{
    display:'flex',
    alignSelf:'center',
    justifyContent:'center'
  },
  CategUi:{
    marginTop:5,
    marginRight:0,
    marginLeft:15,
    marginBottom:5,
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
  },
  EditDataButton:{
    width:'90%',
    height:30,
    margin:10,
    alignSelf:'center'
  },
  EditDataText:{
    backgroundColor:'white',
    width:'100%',
    height:'100%',
    borderRadius: 5,
    borderColor: '#000000',
    borderStyle: 'solid',
    borderWidth: .5
  },
});

export default styles;